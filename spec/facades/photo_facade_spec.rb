require "rails_helper"

RSpec.describe PhotoFacade do
  describe "class methods" do
    describe "::photos_from" do
      it "returns a list of photos", :vcr do
        query = "Thailand"
        photos = PhotoFacade.new.photos_from(query)

        expect(photos).to be_an(Array)

        photos.each do |photo|
          expect(photo.alt_tag).to be_a(String)
          expect(photo.url).to be_a(String)
        end
      end
    end
  end
end
