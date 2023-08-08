require "rails_helper"

RSpec.describe LearningResourcesSerializer, type: :serializer do
  describe "happy path" do
    context "Nigeria" do
      it "should serialize learning resources", :vcr do
        country = "Nigeria"
        video = VideoFacade.new.video_resources(country)
        photos = PhotoFacade.new.photos_from(country)
        response = LearningResourcesSerializer.serialize(country, video, photos)

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

  describe "sad path" do
    it "should serialize empty learning resources" do
      query = "Nameofcountry"
      response = LearningResourcesSerializer.serialize_no_videos(query)

      expect(response).to have_key(:data)
      expect(response[:data]).to be_a(Hash)
      expect(response[:data][:id]).to be(nil)
      expect(response[:data][:type]).to eq("learning_resource")
      expect(response[:data][:attributes]).to be_a(Hash)

      attributes = response[:data][:attributes]

      expect(attributes[:country]).to eq(query)
      expect(attributes[:video]).to be_a(Hash)
      expect(attributes[:video].size).to eq(0)
      expect(attributes[:video]).to_not have_key(:title)
      expect(attributes[:video]).to_not have_key(:youtube_video_id)

      expect(attributes).to have_key(:images)
      expect(attributes[:images]).to be_an(Array)
      expect(attributes[:images].size).to eq(0)
    end
  end
end
