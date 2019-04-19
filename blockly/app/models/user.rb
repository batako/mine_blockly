# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  login_id   :string           not null
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
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
