require "rails_helper"

RSpec.describe Api::V1::RecipesController, type: :routing do
  describe "routing" do
    context "index" do
      it "routes to #index" do
        expect(get: "/api/v1/recipes").to route_to("api/v1/recipes#index")
      end

      it "returns recipes for a specific country", :vcr do
        query = "Thailand"
        visit "/api/v1/recipes?country=#{query}"

        expect(page.status_code).to eq(200)

        response = JSON.parse(page.body, symbolize_names: true)

        expect(response).to have_key(:data)
        expect(response[:data]).to be_an(Array)

        recipes = response[:data]

        recipes.each do |recipe|
          expect(recipe).to have_key(:id)
          expect(recipe[:id]).to eq(nil)

          expect(recipe).to have_key(:type)
          expect(recipe[:type]).to eq("recipe")

          expect(recipe).to have_key(:attributes)
          expect(recipe[:attributes]).to be_a(Hash)

          attributes = recipe[:attributes]

          expect(attributes).to have_key(:title)
          expect(attributes).to have_key(:url)
          expect(attributes).to have_key(:country)
          expect(attributes).to have_key(:image)
        end
      end

      it "returns recipes for an empty query", :vcr do
        countries_data = File.read("./spec/fixtures/manual_data/recipe_data/countries.json")
        saudi = File.read("./spec/fixtures/manual_data/recipe_data/saudi.json")

        stub_request(:get, "http://api.edamam.com/api/recipes/v2?app_id=9c028717&app_key=847a590991d215af6af664e60bd35e3b&type=public&q=Argentina")
          .to_return(status: 200, body: saudi)

        stub_request(:get, "https://restcountries.com/v3.1/all?fields=name")
          .to_return(status: 200, body: countries_data)

        random_country = ""
        visit "/api/v1/recipes?country=#{random_country}"

        expect(page.status_code).to eq(200)

        response = JSON.parse(page.body, symbolize_names: true)

        expect(response).to have_key(:data)
        expect(response[:data]).to be_an(Array)

        recipes = response[:data]

        recipes.each do |recipe|
          expect(recipe).to have_key(:id)
          expect(recipe[:id]).to eq(nil)

          expect(recipe).to have_key(:type)
          expect(recipe[:type]).to eq("recipe")

          expect(recipe).to have_key(:attributes)
          expect(recipe[:attributes]).to be_a(Hash)

          attributes = recipe[:attributes]

          expect(attributes).to have_key(:title)
          expect(attributes).to have_key(:url)
          expect(attributes).to have_key(:country)
          expect(attributes).to have_key(:image)
        end
      end

      context "sad path" do
        it "returns an empty array for a country without recipes", :vcr do
          query = "Mayotta"
          visit "/api/v1/recipes?country=#{query}"

          expect(page.status_code).to eq(200)

          response = JSON.parse(page.body, symbolize_names: true)

          expect(response).to have_key(:data)
          expect(response[:data]).to be_an(Array)

          recipes = response[:data]

          expect(recipes.size).to eq(0)
        end

        it "returns an empty array for a query without recipes", :vcr do
          query = "78905"
          visit "/api/v1/recipes?country=#{query}"

          expect(page.status_code).to eq(200)

          response = JSON.parse(page.body, symbolize_names: true)

          expect(response).to have_key(:data)
          expect(response[:data]).to be_an(Array)

          recipes = response[:data]

          expect(recipes.size).to eq(0)
        end
      end
    end
  end
end
