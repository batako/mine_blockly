# == Schema Information
#
# Table name: workspaces
#
#  id         :integer          not null, primary key
#  created_by :integer          not null
#  name       :string
#  pin        :boolean          default(FALSE), not null
#  share      :boolean          default(FALSE), not null
#  xml        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_workspaces_on_created_by  (created_by)
#  index_workspaces_on_pin         (pin)
#

require 'rails_helper'

RSpec.describe Workspace, type: :model do
  it_behaves_like 'factory'
end
