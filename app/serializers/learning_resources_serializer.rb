class LearningResourcesSerializer
  def self.serialize(country, video, photos)
    {
      data:
      {
        id: nil,
        type: "learning_resource",
        attributes:
        {
          country: country,
          video:
          ## Question: try to rescue with empty hash for video and empty array for photos
          # if video == {}
          #   video: {},
          # else
          #   {
          #     title: video.title,
          #     youtube_video_id: video.youtube_video_id
          #   },
          # end
          {
            title: video.title,
            youtube_video_id: video.youtube_video_id
          },
          images: photos.map do |photo|
            {
              alt_tag: photo.alt_tag,
              url: photo.url
            }
          end
        }
      }
    }
  end

  ## Question: how to do the same thing with JSONAPI::Serializer
  # include JSONAPI::Serializer
  # set_type :learning_resource

  # attributes :title, :youtube_video_id, :country, :images

  # attribute :images do |object|
  #   photos = PhotoFacade.new.photos_from
  # end
  # options[:include] = [:images]

  # has_many :images
end
