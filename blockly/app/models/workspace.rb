class Workspace < ApplicationRecord
  validates :name, presence: true
  validates :xml, presence: true
end
