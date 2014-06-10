class TownsPerson < ActiveRecord::Base
  validates :game_id, uniqueness: { scope: :student_id}
end
