require "rails_helper"

RSpec.describe "Favorites Get Request" do
  let!(:valid_user_params) do
    {
      name: "Odell",
      email: "goodboy1@ruffruff.com",
      password: "treats4lyf",
      password_confirmation: "treats4lyf"
    }
  end

  let!(:user_1) { User.create!(valid_user_params) }
  let!(:user_1_favorites) { create_list(:favorite, 3, user_id: user_1.id) }
  let!(:valid_api_key) { user_1.api_key }
  let!(:invalid_api_key) { "#{user_1.api_key}1" }
  let(:valid_headers) { { "CONTENT_TYPE" => "application/json" } }

  context "happy path" do
    it "can get favorites for a user" do
      get api_v1_favorites_path, params: { api_key: valid_api_key }, headers: valid_headers

      expect(response.status).to eq(200)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to have_key(:data)
      expect(parsed[:data]).to be_an(Array)
      expect(parsed[:data].size).to eq(3)

      expect(parsed[:data].first).to have_key(:id)
      expect(parsed[:data].first[:id].to_i).to eq(user_1_favorites.first.id)
      expect(parsed[:data].first[:type]).to eq("favorite")
      expect(parsed[:data].first[:attributes][:recipe_title]).to eq(user_1_favorites.first.recipe_title)
      expect(parsed[:data].first[:attributes][:recipe_link]).to eq(user_1_favorites.first.recipe_link)
      expect(parsed[:data].first[:attributes][:country]).to eq(user_1_favorites.first.country)

      json_time = JSON.parse(user_1_favorites.first.created_at.to_json)

      expect(parsed[:data].first[:attributes][:created_at]).to eq(json_time)

      parsed[:data].each do |favorite|
        expect(favorite[:attributes]).to have_key(:recipe_title)
        expect(favorite[:attributes]).to have_key(:recipe_link)
        expect(favorite[:attributes]).to have_key(:country)
        expect(favorite[:attributes]).to have_key(:created_at)
      end
    end
  end

  context "sad path" do
    it "renders credential errors when it can't find a users favorites by api key" do
      get api_v1_favorites_path, params: { api_key: invalid_api_key }, headers: valid_headers

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to have_key(:errors)
      expect(parsed[:errors].first[:status]).to eq("401")
      expect(parsed[:errors].first[:title]).to eq("User credentials invalid")
    end
  end
end
