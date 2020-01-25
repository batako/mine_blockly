# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  role       :integer          default("guest"), not null
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  login_id   :string           not null
#
# Indexes
#
#  index_users_on_login_id  (login_id) UNIQUE
#  index_users_on_token     (token) UNIQUE
#

FactoryBot.define do
  factory :user do
    sequence(:name){|n| "name_#{n}"}
    sequence(:login_id){|n| "login_id_#{n}"}
    role { "guest" }
  end
end
