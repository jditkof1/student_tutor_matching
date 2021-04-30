FactoryGirl.define do
  factory :profile do
    primary_language "MyString"
    secondary_language "MyString"
    favorite_movie "MyString"
    worst_movie "MyString"
    favorite_genre "MyString"
    user nil
  end
end
