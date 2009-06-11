class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :user_name
      t.string :password
      t.string :family_name
      t.string :first_name
      t.string :family_name_kana
      t.string :first_name_kana
      t.integer :gender, :limit=>1
      t.string :address1
      t.string :address2
      t.string :home_phone, :limit=>10
      t.string :mobile_phone, :limit=>11
      t.string :mail_address_mobile
      t.string :mail_address_pc
      t.boolean :ritei
      t.datetime :last_login
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
