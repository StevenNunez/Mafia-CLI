class TownsPerson < ActiveRecord::Base
  validates :game_id, uniqueness: { scope: :student_id}
  belongs_to :game
  belongs_to :student

  def self.mafiaize!(game)
    evil = self.where(game: game).sample(4)
    evil.each do |m|
      m.update(mafia: true)
    end
    # self.where(id: evil.map(&:id)).update_all(mafia:true)
  end
end
