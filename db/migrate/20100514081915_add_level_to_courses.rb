class AddLevelToCourses < ActiveRecord::Migration
  def self.up
    add_column :courses, :level_ja, :string
    add_column :courses, :level_en, :string
  end

  def self.down
    remove_column :courses, :level_en
    remove_column :courses, :level_ja
  end
end
