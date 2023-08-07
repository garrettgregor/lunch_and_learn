class Video
  attr_reader :title,
              :youtube_video_id,
              :country,
              :id

  def initialize(data, country)
    @title            = data[:snippet][:title]
    @youtube_video_id = data[:id][:videoId]
    @country          = country
    @id               = nil
  end

  def images
    PhotoFacade.new.photos_from(@country)
  end
end
