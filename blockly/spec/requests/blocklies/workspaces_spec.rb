require 'rails_helper'

RSpec.describe Blocklies::WorkspacesController, type: :request do
  describe "GET #new" do
    subject { get new_workspace_path, xhr: true }

    include_examples "has status code 200"
  end

  describe "GET #edit" do
    subject { get edit_workspace_path(id: workspace.to_param), xhr: true }

    let(:workspace) { create(:workspace) }

    include_examples "has status code 200"
  end

  describe "POST #create" do
    subject { post workspaces_path(workspace: params), xhr: true }

    context "with valid params" do
      let(:params) { {name: "NAME", xml: "XML"} }

      include_examples "has status code 200"

      it "creates a new workspace" do
        expect { subject }.to change(Workspace, :count).by(1)
      end
    end

    context "with invalid params" do
      let(:params) { {name: nil, xml: nil} }

      include_examples "has status code 200"

      it "doesn't create a new workspace" do
        expect { subject }.to change(Workspace, :count).by(0)
      end
    end
  end

  describe "PUT #update" do
    subject { put workspace_path(workspace.to_param, workspace: params), xhr: true }

    let!(:workspace) { create(:workspace) }

    context "with valid params" do
      let(:params) { {name: "updated NAME", xml: "updated XML"} }

      include_examples "has status code 200"

      it "updates the requested workspace" do
        subject
        workspace.reload
        expect(workspace.name).to eq params[:name]
        expect(workspace.xml).to eq params[:xml]
      end
    end

    context "with invalid params" do
      let(:params) { {name: nil, xml: nil} }
      let!(:name) { workspace.name }
      let!(:xml) { workspace.xml }

      include_examples "has status code 200"

      it "doesn't update the requested workspace" do
        subject
        workspace.reload
        expect(workspace.name).to eq name
        expect(workspace.xml).to eq xml
      end
    end
  end

  describe "DELETE #destroy" do
    subject { delete workspace_path(id: workspace.to_param), xhr: true }

    let!(:workspace) { create(:workspace) }

    it "destroys the requested workspace" do
      expect { subject }.to change(Workspace, :count).by(-1)
    end
  end

end
