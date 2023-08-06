require "rails_helper"

RSpec.describe RecipeFacade do
  describe "class methods" do
    describe "::recipes_by_country" do
      context "happy path" do
        it "makes recipes to be serialized", :vcr do
          query = "Thailand"
          recipes = RecipeFacade.new.recipes_by_country(query)
          
          expect(recipes).to be_an(Array)

          recipes.each do |recipe|
            expect(recipe).to be_a(Recipe)
            expect(recipe.country).to eq(query)
            expect(recipe.image).to be_a(String)
            expect(recipe.title).to be_a(String)
            expect(recipe.url).to be_a(String)
          end
        end
      end

      context "sad path" do
        it "makes recipes to be serialized", :vcr do
          query = "78905"
          recipes = RecipeFacade.new.recipes_by_country(query)

          expect(recipes).to be_an(Array)
          expect(recipes.size).to eq(0)
        end
      end
    end
  end
end
