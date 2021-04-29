FactoryGirl.define do

  factory :authorization do
    provider 'github'
    uid      '123456'
    user_id  {nil}
    
    factory :valid_authorization do
      association :user, strategy: :create
    end
  end
end
