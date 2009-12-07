class CreateKunyomis < ActiveRecord::Migration
  def self.up
    create_table :kunyomis do |t|
      t.string :reading

      t.timestamps
    end
  end

  def self.down
    drop_table :kunyomis
  end
end
