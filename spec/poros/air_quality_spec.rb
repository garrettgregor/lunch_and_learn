require "rails_helper"

RSpec.describe AirQuality do
  it "makes air quality objects" do
    attributes =
      {
        CO: { concentration: 410.56, aqi: 4 },
        NO2: { concentration: 2.14, aqi: 2 },
        O3: { concentration: 29.33, aqi: 24 },
        SO2: { concentration: 0.26, aqi: 0 },
        "PM2.5": { concentration: 4, aqi: 12 },
        PM10: { concentration: 4.74, aqi: 4 },
        overall_aqi: 24
      }
    air_quality = AirQuality.new(attributes)

    expect(air_quality).to be_an(AirQuality)
    expect(air_quality.aqi).to eq(attributes[:overall_aqi])
    expect(air_quality.pm25_concentration).to eq(attributes[:"PM2.5"][:concentration].to_f)
    expect(air_quality.co_concentration).to eq(attributes[:CO][:concentration].to_f)
  end
end
