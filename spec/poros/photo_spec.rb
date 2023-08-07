require "rails_helper"

RSpec.describe Photo do
  before(:each) do
    thailand_photos
  end

  it "makes an array of photos" do
    photos = thailand_photos.map do |photo|
      Photo.new(photo)
    end

    photos.each do |photo|
      expect(photo.alt_tag).to be_a(String)
      expect(photo.url).to be_a(String)
    end
  end
end