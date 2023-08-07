class VideoFacade
  def video_resources(country)
    results = service.mrhistory_videos(country)

    @video = Video.new(results[:items].first, country)
  end

  private

  def service
    VideoService.new
  end
end
