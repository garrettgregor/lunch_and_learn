require "rails_helper"

RSpec.describe "Favorites Post Request" do
  let!(:user_1) do
    User.create!(
      name: "Odell",
      email: "goodboy1@ruffruff.com",
      password: "treats4lyf",
      password_confirmation: "treats4lyf"
    )
  end

  let!(:valid_api_key) { user_1.api_key }
  let!(:invalid_api_key) { user_1.api_key + "1" }

  let!(:valid_post_info) do
    {
      api_key: valid_api_key,
      country: "thailand",
      recipe_link: "https://www.tastingtable.com/.....",
      recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
    }
  end

  let!(:invalid_post_info) do
    {
      api_key: invalid_api_key,
      country: "thailand",
      recipe_link: "https://www.tastingtable.com/.....",
      recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
    }
  end

  let(:valid_headers) { { "CONTENT_TYPE" => "application/json" } }

  context "happy path" do
    it "can create a favorite for a user" do
      post api_v1_favorites_path, params: valid_post_info.to_json, headers: valid_headers

      expect(response).to be_successful
      expect(response.status).to eq(201)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to have_key(:success)
      expect(parsed[:success]).to eq("Favorite added successfully")
    end
  end

  context "sad path" do
    it "renders credential errors when it can't find a user by api key" do
      post api_v1_favorites_path, params: invalid_post_info.to_json, headers: valid_headers

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to have_key(:errors)
      expect(parsed[:errors].first[:status]).to eq("401")
      expect(parsed[:errors].first[:title]).to eq("User credentials invalid")
    end
  end
end
