require "rails_helper"

RSpec.describe Video do
  before(:each) do
    thailand_video
  end

  it "makes video objects" do
    country = "Thailand"
    video = Video.new(thailand_video, country)

    expect(video.title).to eq(thailand_video[:snippet][:title])
    expect(video.youtube_video_id).to eq(thailand_video[:id][:videoId])
    expect(video.country).to eq(country)
    expect(video.id).to eq(nil)
  end
end
