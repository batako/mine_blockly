require 'rails_helper'

describe WorkspaceDecorator do
  let(:workspace) { create :workspace }

  before { ActiveDecorator::Decorator.instance.decorate workspace }

  it '#user_name' do
    expect(workspace.user_name).to eq workspace.creator.login_id
  end
end