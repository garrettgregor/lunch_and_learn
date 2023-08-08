require "rails_helper"

RSpec.describe "Sessions Post Request" do
  let!(:user_1) do
    User.create!(
      name: "Odell",
      email: "goodboy1@ruffruff.com",
      password: "treats4lyf",
      password_confirmation: "treats4lyf"
    )
  end

  let!(:valid_login_info) do
    {
      email: "goodboy1@ruffruff.com",
      password: "treats4lyf"
    }
  end

  let!(:invalid_email_login_info) do
    {
      email: "goodboy11@ruffruff.com",
      password: "treats4lyf"
    }
  end

  let!(:invalid_password_login_info) do
    {
      email: "goodboy11@ruffruff.com",
      password: "treats5lyf"
    }
  end

  let(:valid_headers) { { "CONTENT_TYPE" => "application/json" } }

  context "happy path" do
    it "can login a user" do
      post api_v1_sessions_path, params: valid_login_info.to_json, headers: valid_headers

      expect(response).to be_successful
      expect(response.status).to eq(202)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to have_key(:data)
      expect(parsed[:data][:type]).to eq("user")
      expect(parsed[:data][:id].to_i).to eq(user_1.id)
      expect(parsed[:data]).to have_key(:attributes)
      expect(parsed[:data][:attributes][:name]).to eq(user_1.name)
      expect(parsed[:data][:attributes][:email]).to eq(user_1.email)
      expect(parsed[:data][:attributes][:api_key]).to eq(user_1.api_key)
    end
  end

  context "sad path" do
    it "renders credential errors when it can't find a user email" do
      post api_v1_sessions_path, params: invalid_email_login_info.to_json, headers: valid_headers

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to have_key(:error)
      expect(parsed[:error]).to eq("Invalid Email or Password")
    end

    it "renders credential errors when it can't authenticate with password" do
      post api_v1_sessions_path, params: invalid_password_login_info.to_json, headers: valid_headers

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to have_key(:error)
      expect(parsed[:error]).to eq("Invalid Email or Password")
    end
  end
end
