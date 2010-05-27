class CreateBanks < ActiveRecord::Migration
  def self.up
    create_table :banks do |t|
      t.string :name
      t.string :branch
      t.string :account
      t.string :signup_name
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :banks
  end
end
