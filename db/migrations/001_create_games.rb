class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :label
    end
  end
end
