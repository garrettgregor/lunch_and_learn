require "rails_helper"

RSpec.describe Api::V1::RecipesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/recipes").to route_to("api/v1/recipes#index")
    end
  end
end
