# == Schema Information
#
# Table name: workspace_emotions
#
#  id           :integer          not null, primary key
#  workspace_id :integer
#  emotion      :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe WorkspaceEmotion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
