require "rails_helper"

RSpec.describe VideoFacade do
  describe "class methods" do
    describe "::video_resources" do
      context "happy path" do
        it "returns a video", :vcr do
          query = "Thailand"
          video = VideoFacade.new.video_resources(query)

          expect(video).to be_a(Video)
          expect(video.title).to be_a(String)
          expect(video.youtube_video_id).to be_a(String)
        end
      end

      context "sad path" do
        it "returns a video", :vcr do
          query = "Nameofcountry"
          video = VideoFacade.new.video_resources(query)

          expect(video).to be_a(Hash)
          expect(video.size).to eq(0)
        end
      end
    end
  end
end
