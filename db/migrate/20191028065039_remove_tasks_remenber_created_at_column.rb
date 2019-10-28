class RemoveTasksRemenberCreatedAtColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :remenber_created_at
  end
end
