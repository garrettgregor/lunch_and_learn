class PhotoService
  def photos_from(country)
    get_url("search/photos/?query=#{country}")
  end

  private

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.unsplash.com/") do |f|
      f.headers["Authorization"] = ENV["UNSPLASH_API_KEY"]
    end
  end
end
