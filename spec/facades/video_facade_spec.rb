require "rails_helper"

RSpec.describe VideoFacade do
  describe "class methods" do
    describe "::video_resources" do
      it "returns a video", :vcr do
        query = "Thailand"
        video = VideoFacade.new.video_resources(query)

        expect(video).to be_a(Video)
        expect(video.title).to be_a(String)
        expect(video.youtube_video_id).to be_a(String)
        expect(video.country).to eq(query)
        expect(video.id).to eq(nil)
      end
    end
  end
end
