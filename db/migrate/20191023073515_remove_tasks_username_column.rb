class RemoveTasksUsernameColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :username
  end
end
