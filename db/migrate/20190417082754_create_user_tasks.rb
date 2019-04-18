class CreateUserTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tasks do |t|
      t.references :user, foreign_key: true
      t.references :task, foreign_key: true
      t.references :user_subject, foreign_key: true
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
