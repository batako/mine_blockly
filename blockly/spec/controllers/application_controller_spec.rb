require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller ApplicationController do
    def index
      render text: 'index'
    end
  end

  describe '#current_user' do
    context "when create type" do
      let(:user) { create :user }
      before { sign_in user }

      it 'works' do
        expect(controller.current_user.id).to eq user.id
      end
    end

    context "unauthorized access" do
      it "redirect to root" do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
