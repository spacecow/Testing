class CreateOnyomis < ActiveRecord::Migration
  def self.up
    create_table :onyomis do |t|
      t.string :reading

      t.timestamps
    end
  end

  def self.down
    drop_table :onyomis
  end
end
