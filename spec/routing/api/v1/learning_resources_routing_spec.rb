require "rails_helper"

RSpec.describe Api::V1::LearningResourcesController, type: :routing do
  describe "#index" do
    context "happy path" do
      it "routes to #index" do
        expect(get: api_v1_learning_resources_path).to route_to("api/v1/learning_resources#index")
      end

      it "returns learning resources for a specific country", :vcr do
        country = "Nigeria"
        visit api_v1_learning_resources_path(country:)

        expect(page.status_code).to eq(200)

        response = JSON.parse(page.body, symbolize_names: true)

        expect(response).to have_key(:data)
        expect(response[:data]).to be_a(Hash)
        expect(response[:data][:id]).to be(nil)
        expect(response[:data][:type]).to eq("learning_resource")
        expect(response[:data][:attributes]).to be_a(Hash)

        attributes = response[:data][:attributes]

        expect(attributes[:country]).to eq(country)
        expect(attributes[:video]).to be_a(Hash)
        expect(attributes[:video][:title]).to be_a(String)
        expect(attributes[:video][:youtube_video_id]).to be_a(String)

        expect(attributes).to have_key(:images)
        expect(attributes[:images]).to be_an(Array)

        attributes[:images].each do |image|
          expect(image).to have_key(:alt_tag)
          expect(image[:alt_tag]).to be_a(String)
          expect(image).to have_key(:url)
          expect(image[:url]).to be_a(String)
        end
      end

      it "returns learning resources for a random country", :vcr do
        countries_data = File.read("./spec/fixtures/stubs/all_countries_only_greece.json")
        capital = File.read("./spec/fixtures/stubs/greece_capital.json")

        stub_request(:get, "https://restcountries.com/v3.1/name/Greece?fields=capital")
          .to_return(status: 200, body: capital)

        stub_request(:get, "https://restcountries.com/v3.1/all?fields=name")
          .to_return(status: 200, body: countries_data)

        visit api_v1_learning_resources_path(country: "")

        expect(page.status_code).to eq(200)

        response = JSON.parse(page.body, symbolize_names: true)

        expect(response).to have_key(:data)
        expect(response[:data]).to be_a(Hash)
        expect(response[:data][:id]).to be(nil)
        expect(response[:data][:type]).to eq("learning_resource")
        expect(response[:data][:attributes]).to be_a(Hash)

        attributes = response[:data][:attributes]

        expect(attributes[:country]).to be_a(String)
        expect(attributes[:video]).to be_a(Hash)
        expect(attributes[:video][:title]).to be_a(String)
        expect(attributes[:video][:youtube_video_id]).to be_a(String)

        expect(attributes).to have_key(:images)
        expect(attributes[:images]).to be_an(Array)

        attributes[:images].each do |image|
          expect(image).to have_key(:alt_tag)
          expect(image[:alt_tag]).to be_a(String)
          expect(image).to have_key(:url)
          expect(image[:url]).to be_a(String)
        end
      end
    end

    context "sad path" do
      it "returns learning resources for an invalid query", :vcr do
        query = "Nameofcountry"
        visit api_v1_learning_resources_path(country: query)

        expect(page.status_code).to eq(200)

        response = JSON.parse(page.body, symbolize_names: true)

        expect(response).to have_key(:data)
        expect(response[:data]).to be_a(Hash)
        expect(response[:data][:id]).to be(nil)
        expect(response[:data][:type]).to eq("learning_resource")
        expect(response[:data][:attributes]).to be_a(Hash)

        attributes = response[:data][:attributes]

        expect(attributes[:country]).to eq(query)
        expect(attributes[:video]).to be_a(Hash)
        expect(attributes[:video].size).to eq(0)
        expect(attributes[:video]).to_not have_key(:title)
        expect(attributes[:video]).to_not have_key(:youtube_video_id)

        expect(attributes).to have_key(:images)
        expect(attributes[:images]).to be_an(Array)
        expect(attributes[:images].size).to eq(0)
      end
    end
  end
end
