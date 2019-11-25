class AddTasksStateIndex < ActiveRecord::Migration[5.2]
  def self.up
    change_table :tasks do |t|
      t.change :state, :integer, default: 0
    end
  end
  def self.down
    change_table :tasks do |t|
      t.change :state, :integer
    end
  end
end
