require 'rails_helper'

RSpec.describe Blocklies::Workspaces::EmotionsController, type: :controller do
  describe "PUT #update" do
    subject { put :update, params: params, xhr: true }
    let(:user) { workspace_emotion.user }
    let(:workspace) { create :workspace }
    let(:workspace_emotion) { create :workspace_emotion }

    context "when create type" do
      let(:type) { "create" }
      let(:params) {
        {
          type:         type,
          workspace_id: workspace_emotion.workspace_id,
          emotion:      WorkspaceEmotion.emotions.keys.sample
        }
      }
      it "returns a success response" do
        subject
        expect(response).to be_successful
      end
    end

    context "when delete type" do
      let(:type) { "delete" }
      let(:params) {
        {
          type:         type,
          workspace_id: workspace_emotion.workspace_id,
          emotion:      workspace_emotion.emotion
        }
      }

      before {
        sign_in :user
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
