class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :subjectcode
      t.string :title
      t.text :description
      t.datetime :create_date

      t.timestamps null: false
    end
  end
end
