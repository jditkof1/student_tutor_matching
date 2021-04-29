require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create_with_omniauth' do
    it 'is a class method' do
      expect(User).to respond_to(:create_with_omniauth)
    end
    context 'it creates a valid User' do
      let(:info1) {{'name'=> "SUNY Tester", 'email' => "stester@binghamton.edu"}}
      let(:name) {info1['name']}
      let(:email) {info1['email']}
      it 'creates a valid User with a name' do
        user1 = User.create_with_omniauth(info1)
        expect(user1.name).to eq("SUNY Tester")
      end
      it 'creates a valid User with a valid email' do
        user1 = User.create_with_omniauth(info1)
        expect(user1.email).to eq("stester@binghamton.edu")
      end 
      it 'has a valid email' do
        user1 = User.create_with_omniauth(info1)
        expect(user1).to be_valid
      end
    end
    context 'it creates an invalid User' do
      let(:info2) {{'name'=>  "Rando Tester", 'email' => "rtester@random.com"}}
      let(:name) {info2['name']}
      let(:email) {info2['email']}
      it "is invalid with an invalid email" do
        expect {User.create_with_omniauth(info2)}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email must be for Binghamton University")
      end
    end
    context 'a previous user exists' do
      before(:each) do
        @user =  User.create!(name: 'SUNY Tester', email: 'stester@binghamton.edu')
      end 
      it "can recover the previous user" do
        expect(User.find_with_auth_hash(OmniAuth.config.mock_auth[:github][:info])).to eq(@user)
      end
    end
    context 'a previous user does not exist' do
      before(:each) do
        @user =  User.create!(name: 'Other Tester', email: 'otester@binghamton.edu')
      end 
      it "can't recover a previous user that does not exist" do
          expect(User.find_with_auth_hash(OmniAuth.config.mock_auth[:github])).to eq(nil)
      end
    end
  end 
end
