class AddInfoToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :place, :string
    add_column :events, :start_date, :datetime
    add_column :events, :end_date, :datetime
    add_column :events, :pay_method, :string
    add_column :events, :due_date, :datetime
    add_column :events, :cost, :string
    remove_column :events, :date
  end

  def self.down
    remove_column :events, :due_date
    remove_column :events, :pay_method
    remove_column :events, :end_date
    remove_column :events, :start_date
    remove_column :events, :place
    remove_column :events, :cost
    add_column :events, :date, :datetime
  end
end
