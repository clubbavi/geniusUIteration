class CreateTimesheets < ActiveRecord::Migration[5.0]
  def change
    create_table :timesheets do |t|
      t.integer :user_id
      t.datetime :entry_time
      t.timestamps
    end
  end
end
