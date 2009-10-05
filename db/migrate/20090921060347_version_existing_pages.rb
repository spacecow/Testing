class VersionExistingPages < ActiveRecord::Migration
  def self.up
		say_with_time "Setting initial version for pages" do
			Klass.find_each( &:touch )
		end
  end

  def self.down
  end
end
