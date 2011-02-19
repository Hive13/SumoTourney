class DeviseCreateContenders < ActiveRecord::Migration
  def self.up
    create_table(:contenders) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.references :role, :contender

      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    add_index :contenders, :email,                :unique => true
    add_index :contenders, :reset_password_token, :unique => true
    # add_index :contenders, :confirmation_token,   :unique => true
    # add_index :contenders, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :contenders
  end
end
