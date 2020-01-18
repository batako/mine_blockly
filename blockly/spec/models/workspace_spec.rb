# == Schema Information
#
# Table name: workspaces
#
#  id         :integer          not null, primary key
#  name       :string
#  xml        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  created_by :integer          not null
#  share      :boolean          default(FALSE), not null
#  pin        :boolean          default(FALSE), not null
#

require 'rails_helper'

RSpec.describe Workspace, type: :model do
  it_behaves_like 'factory'
end
