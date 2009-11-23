class CreateRegistrants < ActiveRecord::Migration
  def self.up
    create_table :registrants do |t|
      t.string :occupation
    	t.string :name
      t.string :name_hurigana
      t.integer :event_id
      t.boolean :male
      t.string :age
      t.string :tel
      t.string :email
      t.text :note
      t.timestamps
    end
  end
  
  def self.down
    drop_table :registrants
  end
end
