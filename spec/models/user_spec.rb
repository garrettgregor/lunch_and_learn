require "rails_helper"

describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }

    let!(:user_1) do
      User.create!(name: "Testarossa", email: "testarossa@test.com", password: "test", password_confirmation: "test")
    end

    it "generates an api key for the user on creation" do
      expect(user_1.api_key).to_not be(nil)
      expect(user_1.api_key.length).to eq(24)
    end
  end

  describe "relationships" do
    it { should have_many(:favorites) }

    it "removes favorites on deletion" do
      user_1 = User.create!(name: "Testarossa", email: "testarossa@test.com", password: "test", password_confirmation: "test")
      create_list(:favorite, 3, user_id: user_1.id)

      expect(user_1.favorites.size).to eq(3)

      user_1.destroy
      
      expect(Favorite.all.size).to eq(0)
    end
  end
end
