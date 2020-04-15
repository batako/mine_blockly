# == Schema Information
#
# Table name: workspaces
#
#  id         :integer          not null, primary key
#  created_by :integer          not null
#  lock       :boolean
#  name       :string
#  pin        :boolean          default(FALSE), not null
#  share      :boolean          default(FALSE), not null
#  xml        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_workspaces_on_created_by  (created_by)
#  index_workspaces_on_pin         (pin)
#

require 'rails_helper'

RSpec.describe Workspace, type: :model do
  it_behaves_like 'factory'

  describe 'validation' do
    describe '#reject_to_update_lock_workspace' do
      let(:workspace) { build :workspace, name: name, xml: 'xml', lock: lock }
      let(:name) { 'workspace_name' }
      let(:modified_name) { 'modified_name' }
      let(:modified_xml) { 'modified_xml' }

      context 'lock workspace' do
        let(:lock) { true }

        context 'valid' do
          subject { workspace.update(update_params) }
          let(:update_params) {
            {name: modified_name}
          }
          before { workspace.save }

          it { expect(subject).to eq true }
        end

        context 'invalid' do
          subject { workspace.update(update_params) }
          let(:update_params) {
            {xml: modified_xml}
          }
          before { workspace.save }

          it { expect(subject).to eq false }
        end

        context 'reject to delete' do
          before { workspace.save }

          it {
            expect { workspace.destroy }.to change(Workspace, :count).by(0)
          }
        end
      end

      context 'unlock workspace' do
        subject { workspace.update(update_params) }
        let(:lock) { false }

        context 'valid' do
          let(:update_params) {
            {name: modified_name}
          }
          before { workspace.save }

          it { expect(subject).to eq true }
        end

        context 'invalid' do
          let(:update_params) {
            {xml: modified_xml}
          }
          before { workspace.save }

          it { expect(subject).to eq true }
        end
      end
    end
  end

  describe "Workspace.sorted" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  describe "#my_favorite" do
    subject { workspace.my_favorite }
    let(:workspace) { workspace_emotion.workspace }
    let(:workspace_emotion) { create :workspace_emotion, emotion: :favorite }

    it "works" do
      expect(subject.id).to_not eq nil
      expect(subject.id).to eq workspace_emotion.id
    end
  end

  describe "#my_like" do
    subject { workspace.my_like }
    let(:workspace) { workspace_emotion.workspace }
    let(:workspace_emotion) { create :workspace_emotion, emotion: :like }

    it "works" do
      expect(subject.id).to_not eq nil
      expect(subject.id).to eq workspace_emotion.id
    end
  end

  describe "#like_count" do
    subject { workspace.like_count }
    let(:workspace) { create :workspace }
    let!(:favorite_emotion) {
      create :workspace_emotion, emotion: :favorite, workspace: workspace
    }
    let!(:like_emotion) {
      create :workspace_emotion, emotion: :like, workspace: workspace
    }

    it "works" do
      expect(subject).to eq 1
    end
  end

  describe "#mine?" do
    subject { workspace.mine? }
    let(:workspace) { create :workspace, creator: creator }
    let(:creator) { create :user }
    let(:reviewer) { create :user }

    context "when creator" do
      before { User.current = creator }

      it "works" do
        expect(subject).to eq true
      end
    end

    context "when reviewer" do
      before { User.current = reviewer }

      it "works" do
        expect(subject).to eq false
      end
    end
  end
end
