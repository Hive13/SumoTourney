class CreateTournaments < ActiveRecord::Migration
  def self.up
    create_table :tournaments do |t|
      t.integer :benched_bot
      t.integer :first_place
      t.integer :second_place
      t.integer :third_place
      t.integer :max_rounds
      t.integer :current_round

      t.timestamps
    end
  end

  def self.down
    drop_table :tournaments
  end
end
