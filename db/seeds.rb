# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

profiles = [{:primary_language => 'English', :secondary_language => 'I', :favorite_movie => 'Up', :worst_movie => 'Down', :favorite_genre => 'SF', :user_id => 1}
     ]

profiles.each do |profile|
  Profile.create!(profile)
end