class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.date :deadline, null: false, default: -> { 'NOW()' }
      t.integer :status, null: false
      t.integer :priority, null: false
      t.timestamps
    end
    add_index :tasks,[:name, :status]
  end
end
