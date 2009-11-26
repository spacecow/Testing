class AddNationalityToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :nationality, :string
  end

  def self.down
    remove_column :users, :nationality
  end
end
