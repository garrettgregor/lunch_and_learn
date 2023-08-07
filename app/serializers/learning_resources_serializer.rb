class LearningResourcesSerializer
  include JSONAPI::Serializer
  set_type :learning_resource

  attributes :title, :youtube_video_id, :country

  # options[:include] = [:images]

  # has_many :images
end
