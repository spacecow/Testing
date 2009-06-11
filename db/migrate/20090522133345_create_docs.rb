class CreateDocs < ActiveRecord::Migration
  def self.up
    create_table :docs do |t|
    	t.string :title
      t.string :url
      t.text :contents

      t.timestamps
    end
  end

  def self.down
    drop_table :docs
  end
end
