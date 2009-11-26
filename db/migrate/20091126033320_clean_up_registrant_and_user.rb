class CleanUpRegistrantAndUser < ActiveRecord::Migration
  def self.up
    add_column :users, :occupation,    :string
  	add_column :users, :name,          :string
    add_column :users, :name_hurigana, :string
    add_column :users, :male, 				 :boolean
    add_column :users, :age,  				 :string
    add_column :users, :tel,  				 :string
    remove_column :registrants, :occupation
  	remove_column :registrants, :name
    remove_column :registrants, :name_hurigana
    remove_column :registrants, :male
    remove_column :registrants, :age
    remove_column :registrants, :tel
    remove_column :registrants, :email
    add_column :registrants, :user_id, :integer
  end

  def self.down
    remove_column :users, :occupation
  	remove_column :users, :name
    remove_column :users, :name_hurigana
    remove_column :users, :male
    remove_column :users, :age
    remove_column :users, :tel
    add_column :registrants, :occupation,    :string
  	add_column :registrants, :name,          :string
    add_column :registrants, :name_hurigana, :string
    add_column :registrants, :male, 				:boolean
    add_column :registrants, :age,  				:string
    add_column :registrants, :tel,  				:string
    add_column :registrants, :email,				:string
    remove_column :registrants, :user_id
  end
end
