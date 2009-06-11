class AddTostringToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :tostring, :string
  end

  def self.down
    remove_column :people, :tostring
  end
end
