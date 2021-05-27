class AddSubjectsToSchedule < ActiveRecord::Migration
  def change
    add_reference :schedules, :subjects, index: true, foreign_key: true
  end
end
