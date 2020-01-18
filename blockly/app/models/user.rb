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

class User < ApplicationRecord
  has_many :workspaces, foreign_key: 'created_by'
  has_many :emotions, through: :workspaces

  enum role: {
    guest: 0,
    admin: 1
  }

  def self.authenticate!(login_id)
    user = find_or_create_by(login_id: login_id)
    user.generate_token!
    user
  end

  def self.current
    RequestStore.store[:current_user]
  end

  def self.current=(user)
    RequestStore.store[:current_user] = user
  end

  def generate_token!
    token = nil

    loop do
      self.token = Digest::MD5.hexdigest(SecureRandom.urlsafe_base64)
      break unless User.exists?(token: self.token)
    end

    save!
  end
end
