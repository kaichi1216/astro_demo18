class SetTaskTable < ActiveRecord::Migration[5.2]
  def self.up
    change_table :tasks do |t|
      t.change :task, :string, null: false
    end
  end
  def self.down
    change_table :tasks do |t|
      t.change :task, :string
    end
  end
end
