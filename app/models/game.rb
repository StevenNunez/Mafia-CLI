class Game < ActiveRecord::Base
  validates :label, presence: true
  has_many :towns_people
  has_many :students, through: :towns_people

  after_create :populate_townspeople

  def populate_townspeople
    Student.join_game(self)
    TownsPerson.mafiaize!(self)
  end

  def over?
    mafia_win? || mafia_lose?
  end

  def mafia_win?
    mafia.count >= good_folks.count
  end

  def mafia_lose?
    mafia.count.zero?
  end

  def mafia_kill
    dead = good_folks.sample.destroy
    dead.student.name
  end

  def mob_kill(name)
    # raise exception if student not found
    chop_block = Student.find_by(name: name)

    towns_person = TownsPerson.find_by(game: self, student: chop_block)
    if towns_person
      towns_person.destroy.mafia?
    else
      raise "#{name} is already DEAD!!!!"
    end
  end

  def good_folks
    self.towns_people.where(mafia: false)
  end

  def mafia
    self.towns_people.where(mafia: true)
  end

  def mafia_members
    Student.joins(:towns_people).where(towns_people: {mafia: true, game: self})
  end

  def survivors
    self.students.pluck(:name)  
  end
end

# If mafia.count == good_folks.count Mafia wins show mafia
# If mafia.count.zero? Good Folks win, YEY YOU KILLED THE MAFIA


