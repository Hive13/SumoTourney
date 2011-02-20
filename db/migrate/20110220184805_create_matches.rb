class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.timestamp :start
      t.integer :first_bot_id
      t.integer :second_bot_id
      t.integer :first_bot_score
      t.integer :second_bot_score
      t.integer :round
      t.integer :winning_bot
      t.integer :losing_bot
      t.boolean :completed

      t.timestamps
    end
  end

  def self.down
    drop_table :matches
  end
end
