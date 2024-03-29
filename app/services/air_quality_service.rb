class AirQualityService
  def air_quality_in(capital)
    get_url("/v1/airquality?city=#{capital}")
  end

  private

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.api-ninjas.com/") do |f|
      f.headers["X-Api-Key"] = ENV["API_NINJA_API_KEY"]
    end
  end
end
