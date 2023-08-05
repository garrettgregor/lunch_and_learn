require "rails_helper"

RSpec.describe Api::V1::RecipesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/recipes").to route_to("api/v1/recipes#index")
    end

    ## Question: is this the correct way to be testing the response?
    it "returns recipes", :vcr do
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

    it "returns an empty array", :vcr do
      query = ""
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
