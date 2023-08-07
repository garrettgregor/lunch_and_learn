require "rails_helper"

RSpec.describe Api::V1::LearningResourcesController, type: :routing do
  describe "routing" do
    context "index" do
      it "routes to #index" do
        expect(get: "/api/v1/learning_resources").to route_to("api/v1/learning_resources#index")
      end
    end
  end
end
