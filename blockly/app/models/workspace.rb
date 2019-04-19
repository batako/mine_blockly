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
#

class Workspace < ApplicationRecord
  belongs_to :creator, class_name:'User', foreign_key: :created_by

  validates :name, presence: true
  validates :xml, presence: true

  before_validation :set_created_by

  scope :_mine, ->{ where(created_by: User.current) }
  scope :_theirs, ->{ where.not(created_by: User.current) }
  scope :_share, ->{ where(share: true) }

  private
    def set_created_by
      self.created_by = User.current.try(:id)
    end
end
