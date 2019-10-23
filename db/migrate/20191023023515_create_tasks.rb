class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :username
      t.string :task
      
      t.references :user, foreign_key: true
      t.datetime :remenber_created_at
      t.timestamps
    end
  end
end
