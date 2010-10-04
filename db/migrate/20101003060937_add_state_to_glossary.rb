class AddStateToGlossary < ActiveRecord::Migration
  def self.up
    add_column :glossaries, :state, :integer, :default => 0
  end

  def self.down
    remove_column :glossaries, :state
  end
end
