class VideoFacade
  def video_resources(country)
    results = service.mrhistory_videos(country)

    @video = Video.new(results[:items].first)
    ## Question: how to return an empty hash for an error with no video
    # if !results[:items].first.nil?
    #   @video = Video.new(results[:items].first)
    # else
    #   return {}
    # end
  end

  private

  def service
    VideoService.new
  end
end
