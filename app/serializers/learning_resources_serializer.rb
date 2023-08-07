class LearningResourcesSerializer
  include JSONAPI::Serializer
  set_type :learning_resource

  attributes :title, :youtube_video_id, :country, :images

  # attribute :images do |object|
  #   photos = PhotoFacade.new.photos_from
  # end
  # options[:include] = [:images]

  # has_many :images
end
