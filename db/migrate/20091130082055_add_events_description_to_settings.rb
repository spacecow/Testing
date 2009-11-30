class AddEventsDescriptionToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :events_description_en, :text
    add_column :settings, :events_description_ja, :text
  end

  def self.down
    remove_column :settings, :events_description_ja
    remove_column :settings, :events_description_en
  end
end
