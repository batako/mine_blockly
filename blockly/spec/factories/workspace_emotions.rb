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

FactoryBot.define do
  factory :workspace_emotion do
    user { nil }
    emotion { 1 }
  end
end
