class CreateMeanings < ActiveRecord::Migration
  def self.up
    create_table :meanings do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :meanings
  end
end
