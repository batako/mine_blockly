require 'rails_helper'

RSpec.describe Blocklies::Workspaces::EmotionsController, type: :controller do
  describe "PUT #update" do
    subject { put :update, params: params, xhr: true }
    let(:user) { create :user }
    let(:workspace) { create :workspace, creator: user }

    context "when create type" do
      let(:type) { "create" }
      let(:params) {
        {
          type:         type,
          workspace_id: workspace.id,
          emotion:      WorkspaceEmotion.emotions.keys.sample
        }
      }

      before { sign_in :user }

      it "returns a success response" do
        subject
        expect(response).to be_successful
      end

      it "create a workspace_emotion" do
        expect {
          subject
        }.to change(WorkspaceEmotion, :count).by(1)
      end
    end

    context "when delete type" do
      let(:workspace_emotion) { create :workspace_emotion, user: user }
      let(:type) { "delete" }
      let(:params) {
        {
          type:         type,
          workspace_id: workspace_emotion.workspace_id,
          emotion:      workspace_emotion.emotion
        }
      }

      before {
        sign_in user
        subject
      }

      it "returns a success response" do
        expect(response).to be_successful
      end

      it "delete a workspace_emotion" do
        expect(
          WorkspaceEmotion.find_by(id: workspace_emotion.id)
        ).to eq nil
      end
    end
  end
end
