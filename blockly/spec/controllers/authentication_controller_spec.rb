require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "POST #sign_in" do
    subject { post :sign_in, params: params, xhr: true }
    let(:user) { create :user }
    let(:valid_params) { {login_id: user.login_id} }
    let(:invalid_params) { {} }

    context "when success" do
      let(:params) { valid_params }

      before { subject }

      it "returns a success response" do
        expect(response).to be_successful
      end

      it "get a user token" do
        expect(session[:token]).to_not eq nil
        expect(session[:token]).to eq user.reload.token
      end

      it "redirect to home" do
        expect(response).to redirect_to(blocklies_path)
      end
    end

    context "when failure" do
      let(:params) { invalid_params }

      before { subject }

      it "redirect to root" do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "DELETE #sign_out" do
    subject { delete :sign_out, params: {}, xhr: true }
    let(:params) { {login_id: user.login_id} }
    let(:user) { create :user }
    let(:sign_in) {
      post :sign_in, params: {login_id: user.login_id}, xhr: true
    }

    before { sign_in }

    it "signed in" do
      expect(session[:token]).to_not eq nil
      expect(session[:token]).to eq user.reload.token
    end

    it "returns a success response" do
      subject
      expect(response).to be_successful
    end

    it "delete a user token" do
      subject
      expect(session[:token]).to eq nil
      expect(user.reload.token).to eq nil
    end

    it "redirect to root" do
      subject
      expect(response).to redirect_to(root_path)
    end
  end
end
