require "rails_helper"

RSpec.describe Api::V1::FavoritesController, type: :routing do
  describe "#create" do
    context "happy path" do
      it "routes to #create" do
        expect(post: api_v1_favorites_path).to route_to("api/v1/favorites#create")
      end
    end
  end
end
