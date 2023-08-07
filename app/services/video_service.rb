class VideoService
  def mrhistory_videos(country)
    get_url("youtube/v3/search?q=#{country}")
  end

  private

  def get_url(url)
    response = mrhistory_conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def mrhistory_conn
    Faraday.new(url: "https://youtube.googleapis.com/") do |f|
      f.params["key"] = ENV["YOUTUBE_API_KEY"]
      f.params["channelId"] = "UCluQ5yInbeAkkeCndNnUhpw"
      f.params["maxResults"] = 1
      f.params["part"] = "snippet"
    end
  end
end
