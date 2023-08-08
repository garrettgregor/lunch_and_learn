require "rails_helper"

RSpec.describe Api::V1::SessionsController, type: :routing do
  describe "#create" do
    context "happy path" do
      it "routes to #create" do
        expect(post: api_v1_sessions_path).to route_to("api/v1/sessions#create")
      end
    end
  end
end
