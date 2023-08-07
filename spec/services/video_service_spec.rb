require "rails_helper"

RSpec.describe VideoService do
  describe "class methods" do
    describe "::mr_history_videos" do
      context "happy path" do
        it "returns a list of youtube videos from a search query", :vcr do
          query = "Thailand"
          results = VideoService.new.mrhistory_videos(query)

          expect(results).to be_a(Hash)
          expect(results).to have_key(:items)
          expect(results[:items]).to be_an(Array)
          expect(results[:items].size).to eq(1)

          items = results[:items]

          items.each do |item|
            expect(item).to have_key(:id)
            expect(item[:id]).to be_a(Hash)

            expect(item[:id]).to have_key(:videoId)

            expect(item).to have_key(:snippet)
            expect(item[:snippet]).to be_a(Hash)
            expect(item[:snippet]).to have_key(:title)
          end
        end
      end

      context "sad path" do
        it "returns an empty list of videos for an an empty search query"
      #     query = "78905"
        # end
      end
    end
  end
end
