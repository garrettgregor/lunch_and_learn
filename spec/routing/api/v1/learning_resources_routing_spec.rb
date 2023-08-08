require "rails_helper"

RSpec.describe Api::V1::LearningResourcesController, type: :routing do
  describe "#index" do
    context "happy path" do
      it "routes to #index" do
        expect(get: "/api/v1/learning_resources").to route_to("api/v1/learning_resources#index")
      end

      it "returns learning resources for a specific country", :vcr do
        country = "Nigeria"
        video = VideoFacade.new.video_resources(country)
        photos = PhotoFacade.new.photos_from(country)
        visit "/api/v1/learning_resources?country=#{country}"

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
        expect(attributes[:video][:title]).to eq(video.title)
        expect(attributes[:video][:youtube_video_id]).to eq(video.youtube_video_id)

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
        countries_data = File.read("./spec/fixtures/manual_data/recipe_data/countries.json")
        saudi = File.read("./spec/fixtures/manual_data/recipe_data/saudi.json")

        ## Question: how to hide API/APP key in test environment
        ## Question: why doesn't this test empty params? Better way to test?
        stub_request(:get, "http://api.edamam.com/api/recipes/v2?app_id=9c028717&app_key=847a590991d215af6af664e60bd35e3b&type=public&q=Saudi Arabia")
          .to_return(status: 200, body: saudi)

        stub_request(:get, "https://restcountries.com/v3.1/all?fields=name")
          .to_return(status: 200, body: countries_data)

        random_country = ""
        visit "/api/v1/recipes?country=#{random_country}"
        country = CountryFacade.new.random_country.name
        video = VideoFacade.new.video_resources(country)
        photos = PhotoFacade.new.photos_from(country)
        visit "/api/v1/learning_resources?country=#{country}"

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
        expect(attributes[:video][:title]).to eq(video.title)
        expect(attributes[:video][:youtube_video_id]).to eq(video.youtube_video_id)

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
  end
end
