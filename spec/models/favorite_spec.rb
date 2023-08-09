require "rails_helper"

describe Favorite, type: :model do
  describe "validations" do
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:recipe_link) }
    it { should validate_presence_of(:recipe_title) }
  end

  describe "relationships" do
    it { should belong_to(:user) }
  end
end
