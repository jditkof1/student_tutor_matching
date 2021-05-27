class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :tutor
      t.string :subject
      t.string :student
      t.datetime :timeslot

      t.timestamps null: false
    end
  end
end
