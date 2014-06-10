class Student < ActiveRecord::Base
  validates :name, presence: true
  has_many :towns_people
  has_many :games, through: :towns_people

  def self.join_game(game)
    self.all.each do |s|
      s.games << game
    end
  end
end
