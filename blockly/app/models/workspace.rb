# == Schema Information
#
# Table name: workspaces
#
#  id         :integer          not null, primary key
#  created_by :integer          not null
#  lock       :boolean
#  name       :string
#  pin        :boolean          default(FALSE), not null
#  share      :boolean          default(FALSE), not null
#  xml        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_workspaces_on_created_by  (created_by)
#  index_workspaces_on_pin         (pin)
#

class Workspace < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :created_by
  has_many :emotions, class_name: 'WorkspaceEmotion', dependent: :destroy

  validates :name, presence: true
  validates :xml, presence: true

  before_validation :set_created_by

  scope :_mine, ->{ where(created_by: User.current) }
  scope :_theirs, ->{ where.not(created_by: User.current) }
  scope :_share, ->{ where(share: true) }

  def self.sorted
    all.includes(:emotions).sort_by{|w|
      [
        w.pin ? 0 : 1,
        w.emotions.find{|e| e.user_id == User.current.id && e.favorite? } ? 0: 1,
        - w.created_at.to_i
      ]
    }
  end

  def my_favorite
    emotions.favorite._mine.first
  end

  def my_like
    emotions.like._mine.first
  end

  def like_count
    emotions.like.size
  end

  def mine?
    created_by == User.current.id
  end

  private
    def set_created_by
      self.created_by ||= User.current.try(:id)
    end
end
