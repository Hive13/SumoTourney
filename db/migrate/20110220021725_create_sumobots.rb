class CreateSumobots < ActiveRecord::Migration
  def self.up
    create_table :sumobots do |t|
      t.integer :contender_id
      t.string  :botname
      t.string  :bot_url
      t.integer :wins
      t.integer :loses
      t.integer :ties
      t.integer :matches
      t.string  :pic_file_name
      t.string  :pic_content_type
      t.integer :pic_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :sumobots
  end
end
