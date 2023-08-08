require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}

    let!(:user_1) { User.create!(name: "Testarossa", email: "testarossa@test.com", password: "test") }

    it "generates an api key for the user on creation" do
      expect(user_1.api_key).to_not be(nil)
    end
  end
end