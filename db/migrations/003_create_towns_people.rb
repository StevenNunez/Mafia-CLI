class CreateTownsPeople < ActiveRecord::Migration
  def change
    create_table :towns_people do |t|
      t.belongs_to :game
      t.belongs_to :student
      t.boolean :mafia, default: false
    end
  end
end
