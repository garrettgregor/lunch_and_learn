require "rails_helper"

RSpec.describe RecipeService do
  describe "class methods" do
    describe "::search" do
      context "happy path" do
        it "returns a list of recipes from a search query", :vcr do
          results = RecipeService.new.search("Thailand")

          expect(results).to be_a(Hash)
          expect(results).to have_key(:hits)
          expect(results[:hits]).to be_an(Array)
          
          hits = results[:hits]

          hits.each do |hit|
            expect(hit).to have_key(:recipe)

            recipe = hit[:recipe]

            expect(recipe).to have_key(:label)
            expect(recipe).to have_key(:url)
            expect(recipe).to have_key(:image)
          end
        end
      end
    end
  end
end