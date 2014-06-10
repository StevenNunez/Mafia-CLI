class Game < ActiveRecord::Base
  validates :label, presence: true
  has_many :towns_people
  has_many :students, through: :towns_people

  after_create :populate_townspeople

  def populate_townspeople
    Student.join_game(self)
    TownsPerson.mafiaize!(self)
  end
end
