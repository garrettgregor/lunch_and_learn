require "rails_helper"

RSpec.describe "Users Post Request" do
  let!(:valid_attributes) {
    (
      {
        name: "Odell",
        email: "goodboy1@ruffruff.com",
        password: "treats4lyf",
        password_confirmation: "treats4lyf"
      }
    )
  }

  let!(:invalid_password_confirmation) {
    (
      {
        name: "Odell",
        email: "goodboy1@ruffruff.com",
        password: "treats4lyf",
        password_confirmation: "treats4lyf1"
      }
    )
  }

  let(:valid_headers) { {'CONTENT_TYPE' => 'application/json'} }

  context "happy path" do
    it "can create a user" do
      post api_v1_users_path, params: valid_attributes.to_json, headers: valid_headers

      expect(request.POST.empty?).to be(false)
      expect(request.GET.empty?).to be(true)
      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(response.body).to be_a(String)

      created_user = User.last

      expect(created_user.name).to eq(valid_attributes[:name])
      expect(created_user.email).to eq(valid_attributes[:email])
      expect(created_user.api_key).to_not be(nil)
    end
  end

  context "sad path" do
    it "returns an error when passwords don't match" do
      post api_v1_users_path, params: invalid_password_confirmation.to_json, headers: valid_headers

      expect(response.status).to eq(404)
      message = JSON.parse(response.body, symbolize_names: true)
      error = "Password confirmation doesn't match Password"
      expect(message[:errors].first[:title].first).to eq(error)

      expect {
        post api_v1_users_path,
        params: invalid_password_confirmation, headers: valid_headers, as: :json
      }.to_not change(User, :count)
    end

    it "returns an error when email is already taken" do
      User.create!(valid_attributes)
      post api_v1_users_path, params: valid_attributes.to_json, headers: valid_headers

      expect(response.status).to eq(404)
      message = JSON.parse(response.body, symbolize_names: true)
      error = "Email has already been taken"
      expect(message[:errors].first[:title].first).to eq(error)

      expect {
        post api_v1_users_path,
        params: invalid_password_confirmation, headers: valid_headers, as: :json
      }.to_not change(User, :count)
    end
  end
end
