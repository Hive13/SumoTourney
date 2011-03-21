class CreateTeamApprovals < ActiveRecord::Migration
  def self.up
    create_table :team_approvals do |t|
      t.string :status
      t.integer :from_contender
      t.integer :to_contender
      t.integer :team_id
      t.string  :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :team_approvals
  end
end
