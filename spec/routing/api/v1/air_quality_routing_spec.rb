require "rails_helper"

RSpec.describe Api::V1::AirQualityController, type: :routing do
  describe "routing" do
    context "index" do
      it "routes to #index" do
        expect(get: "/api/v1/air_quality").to route_to("api/v1/air_quality#index")
      end

      context "Nigeria" do
        it "returns air quality for a specific country", :vcr do
          query = "Nigeria"
          visit "/api/v1/air_quality?country=#{query}"

          expect(page.status_code).to eq(200)

          response = JSON.parse(page.body, symbolize_names: true)

          expect(response).to have_key(:data)
          expect(response[:data]).to be_a(Hash)
          expect(response[:data][:id]).to be(nil)
          expect(response[:data][:type]).to eq("air_quality")
          expect(response[:data][:city]).to eq("Abuja")
          expect(response[:data][:attributes]).to be_a(Hash)

          attributes = response[:data][:attributes]

          expect(attributes[:aqi]).to be_a(Float)
          expect(attributes[:pm25_concentration]).to be_a(Float)
          expect(attributes[:co_concentration]).to be_a(Float)
        end
      end

      context "France" do
        it "returns air quality for a specific country", :vcr do
          query = "France"
          visit "/api/v1/air_quality?country=#{query}"

          expect(page.status_code).to eq(200)

          response = JSON.parse(page.body, symbolize_names: true)

          expect(response).to have_key(:data)
          expect(response[:data]).to be_a(Hash)
          expect(response[:data][:id]).to be(nil)
          expect(response[:data][:type]).to eq("air_quality")
          expect(response[:data][:city]).to eq("Paris")
          expect(response[:data][:attributes]).to be_a(Hash)

          attributes = response[:data][:attributes]

          expect(attributes[:aqi]).to be_a(Float)
          expect(attributes[:pm25_concentration]).to be_a(Float)
          expect(attributes[:co_concentration]).to be_a(Float)
        end
      end
    end
  end
end
