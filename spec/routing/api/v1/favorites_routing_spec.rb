require "rails_helper"

RSpec.describe Api::V1::FavoritesController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(post: api_v1_favorites_path).to route_to("api/v1/favorites#create")
    end

    it "routes to #index" do
      expect(get: api_v1_favorites_path).to route_to("api/v1/favorites#index")
    end
  end
end
