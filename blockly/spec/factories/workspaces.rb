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

FactoryBot.define do
  factory :workspace do
    sequence(:name){|n| "NAME #{n}"}
    sequence(:xml){|n| "XML #{n}"}
    creator { create :user }
  end
end
