require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller ApplicationController do end

  describe '#current_user' do
    let(:user) { create :user }
    before { sign_in user }

    it 'works' do
      expect(controller.current_user.id).to eq user.id
    end
  end
end
