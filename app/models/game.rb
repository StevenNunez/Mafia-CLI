class Game < ActiveRecord::Base
  validates :label, presence: true
  has_many :towns_people
  has_many :students, through: :towns_people
end
