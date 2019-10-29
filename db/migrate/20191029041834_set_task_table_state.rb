class SetTaskTableState < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :state, :integer, using: 'state::integer'
  end
end
