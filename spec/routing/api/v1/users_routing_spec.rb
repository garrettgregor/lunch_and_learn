require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :routing do
  describe "#index" do
    context "happy path" do
      it "routes to #index" do
        expect(get: api_v1_users_path).to route_to("api/v1/users#index")
      end
    end
  end
end
