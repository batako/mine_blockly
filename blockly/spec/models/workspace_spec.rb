# == Schema Information
#
# Table name: workspaces
#
#  id         :integer          not null, primary key
#  name       :string
#  xml        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Workspace, type: :model do
  let(:workspace) { build(:workspace) }

  it "is valid" do
    expect(workspace).to be_valid
  end

  it "is invalid without a name" do
    workspace.name = nil
    expect(workspace).to be_invalid
  end

  it "is invalid without a xml" do
    workspace.xml = nil
    expect(workspace).to be_invalid
  end
end
