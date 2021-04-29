class CreatePairings < ActiveRecord::Migration
  def change
    create_table :pairings do |t|
      t.string :tutor
      t.string :student
      t.string :subject
      t.datetime :date

      t.timestamps null: false
    end
  end
end
