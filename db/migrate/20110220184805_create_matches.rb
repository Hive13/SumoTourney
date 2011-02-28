class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.timestamp :start
      t.integer :first_bot_id
      t.integer :second_bot_id
      t.integer :first_bot_round1_score
      t.integer :second_bot_round1_score
      t.integer :first_bot_round2_score
      t.integer :second_bot_round2_score
      t.integer :first_bot_round3_score
      t.integer :second_bot_round3_score
      t.integer :round
      t.integer :winning_bot
      t.integer :losing_bot
      t.integer :tournament_id
      t.integer :tournament_round
      t.integer :first_bot_from_match
      t.integer :second_bot_from_match

      t.timestamps
    end
  end

  def self.down
    drop_table :matches
  end
end
