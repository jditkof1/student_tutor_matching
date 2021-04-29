class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :primary_language
      t.string :secondary_language
      t.string :favorite_movie
      t.string :worst_movie
      t.string :favorite_genre
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
