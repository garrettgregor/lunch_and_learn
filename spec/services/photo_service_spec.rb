require "rails_helper"

RSpec.describe PhotoService do
  describe "class methods" do
    describe "::photos_from" do
      context "happy path" do
        it "returns a list of youtube videos from a search query", :vcr do
          query = "Thailand"
          results = PhotoService.new.photos_from(query)

          expect(results).to be_a(Hash)
          expect(results).to have_key(:results)
          expect(results[:results]).to be_an(Array)
          expect(results[:results].size).to be <= 10

          images = results[:results]

          images.each do |image|
            expect(image).to have_key(:alt_description)
            expect(image[:alt_description]).to be_a(String)

            expect(image).to have_key(:urls)
            expect(image[:urls]).to be_a(Hash)

            expect(image[:urls]).to have_key(:raw)
          end
        end
      end

      context "sad path" do
      #   xit "returns an empty list of recipes from an empty search query", :vcr do
      #     query = "78905"
      #     results = RecipeService.new.search(query)

      #     expect(results).to be_a(Hash)
      #     expect(results).to have_key(:hits)
      #     expect(results[:hits]).to be_an(Array)
      #     expect(results[:hits].size).to eq(0)
      #   end
      end
    end
  end
end
