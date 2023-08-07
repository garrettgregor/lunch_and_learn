class AirQualitySerializer
  def self.serialize(capital, air_quality)
    {
      "data":
      {
        "id": nil,
        "type": "air_quality",
        "city": capital.name,
        "attributes":
        {
          "aqi": air_quality.aqi,
          "pm25_concentration": air_quality.pm25_concentration,
          "co_concentration": air_quality.co_concentration
        }
      }
    }
  end
  ## Question: how do I accomplish the above with the JSONAPI serializer?
  # include JSONAPI::Serializer

  # set_type :air_quality

  # attributes :aqi, :pm25_concentration, :co_concentration, :city
end
