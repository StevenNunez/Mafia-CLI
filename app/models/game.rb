class Game < ActiveRecord::Base
  validates :label, presence: true
end
