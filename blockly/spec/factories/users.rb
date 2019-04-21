# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  login_id   :string           not null
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role       :integer          default("guest"), not null
#

FactoryBot.define do
  factory :user do
    
  end
end
