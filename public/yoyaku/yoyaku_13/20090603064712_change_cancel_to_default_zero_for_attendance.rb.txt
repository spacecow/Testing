class ChangeCancelToDefaultZeroForAttendance < ActiveRecord::Migration  
  def self.up
    change_table :attendances do |t|
      t.change :cancel, :boolean, :default=>0
    end
  end

  def self.down
    change_table :attendances do |t|
      t.change :cancel, :boolean
    end
  end
end
