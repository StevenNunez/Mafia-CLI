class Student < ActiveRecord::Base
  validates :name, presence: true
  has_many :towns_people
  has_many :games, through: :towns_people
end
