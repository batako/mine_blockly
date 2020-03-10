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

  scope :_has_token, ->{ where.not(token: nil) }

  validates :login_id, presence: true,
                       uniqueness: true,
                       format: {
                         with: /\A[a-z0-9]+\z/
                       }

  def self.authenticate!(login_id)
    user = find_or_create_by(login_id: login_id)
    user.generate_token!
    User.current = user
    user
  end

  def self.extinguish!
    User.current.update!(token: nil)
    User.current = nil
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
      token = Digest::MD5.hexdigest(SecureRandom.urlsafe_base64)
      break unless User.exists?(token: token)
    end

    update!(token: token)
  end
end
