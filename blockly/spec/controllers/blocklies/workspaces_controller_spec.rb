require 'rails_helper'

RSpec.describe Blocklies::WorkspacesController, type: :controller do

  let(:valid_attributes) {
    {name: "NAME", xml: "XML"}
  }

  let(:invalid_attributes) {
    {name: nil, xml: nil}
  }

  let(:valid_session) { {} }

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session, xhr: true
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      workspace = Workspace.create! valid_attributes
      get :edit, params: {id: workspace.to_param}, session: valid_session, xhr: true
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Workspace" do
        expect {
          post :create, params: {workspace: valid_attributes}, session: valid_session, xhr: true
        }.to change(Workspace, :count).by(1)
      end
    end

    context "with invalid params" do
      it "returns a success response" do
        post :create, params: {workspace: invalid_attributes}, session: valid_session, xhr: true
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {name: "updated NAME", xml: "updated XML"}
      }

      it "updates the requested workspace" do
        workspace = Workspace.create! valid_attributes
        put :update, params: {id: workspace.to_param, workspace: new_attributes}, session: valid_session, xhr: true
        workspace.reload
        expect(workspace.name).to eq new_attributes[:name]
        expect(workspace.xml).to eq new_attributes[:xml]
      end
    end

    context "with invalid params" do
      it "returns a success response" do
        workspace = Workspace.create! valid_attributes
        put :update, params: {id: workspace.to_param, workspace: invalid_attributes}, session: valid_session, xhr: true
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested workspace" do
      workspace = Workspace.create! valid_attributes
      expect {
        delete :destroy, params: {id: workspace.to_param}, session: valid_session, xhr: true
      }.to change(Workspace, :count).by(-1)
    end
  end

end
