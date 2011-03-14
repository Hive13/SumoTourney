class CreateHackerspaces < ActiveRecord::Migration
  def self.up
    create_table :hackerspaces do |t|
      t.string :name
      t.string :url
      t.string :pic_file_name
      t.string :pic_content_type
      t.integer :pic_file_size
      t.integer :contender_id

      t.timestamps
    end
  end

  def self.down
    drop_table :hackerspaces
  end
end
