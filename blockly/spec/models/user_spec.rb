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

require 'rails_helper'

RSpec.describe User, type: :model do
  it_behaves_like 'factory'
end
