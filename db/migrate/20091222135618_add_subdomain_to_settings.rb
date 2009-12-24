class AddSubdomainToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :subdomain, :string
  end

  def self.down
    remove_column :settings, :subdomain
  end
end
