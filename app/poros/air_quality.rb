class AirQuality
  attr_reader :aqi,
              :pm25_concentration,
              :co_concentration,
              :city,
              :id

  def initialize(data, city)
    @aqi                = data[:overall_aqi].to_f
    @pm25_concentration = data[:"PM2.5"][:concentration].to_f
    @co_concentration   = data[:CO][:concentration].to_f
    @city               = city
    @id                 = nil
  end
end