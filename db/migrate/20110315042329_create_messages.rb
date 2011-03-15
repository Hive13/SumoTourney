class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :contender_id
      t.string :msgtype
      t.string :msg

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
