class Game < ActiveRecord::Base
  validates :label, presence: true
  has_many :towns_people
  has_many :students, through: :towns_people

  after_create :populate_townspeople

  def populate_townspeople
    Student.join_game(self)
    TownsPerson.mafiaize!(self)
  end

  def mafia_kill
    good_folks.sample.destroy
  end

  def mob_kill(name)
    chop_block = Student.find_by(name: name)
    TownsPerson.find_by(game: self, student: chop_block).destroy
  end

  def good_folks
    self.towns_people.where(mafia: false)
  end
end
