require 'rails_helper'

RSpec.describe RecipeSerializer do
  it 'should serialize recipes', :vcr do
    query = "Thailand"
    results = RecipeFacade.new.recipes_by_country(query)
    response = RecipeSerializer.new(results).to_json

    recipes = JSON.parse(response, symbolize_names: true)

    expect(recipes[:data]).to be_an(Array)
    expect(recipes[:data].size).to eq(20)

    recipes[:data].each do |recipe|
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

  it 'will return an empty array for an empty search query', :vcr do
    query = ""
    results = RecipeFacade.new.recipes_by_country(query)
    response = RecipeSerializer.new(results).to_json

    recipes = JSON.parse(response, symbolize_names: true)

    expect(recipes[:data]).to be_an(Array)
    expect(recipes[:data].size).to eq(0)
  end
end