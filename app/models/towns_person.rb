class TownsPerson < ActiveRecord::Base
  validates :game_id, uniqueness: { scope: :student_id}
  belongs_to :game
  belongs_to :student
end
