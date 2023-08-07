require "rails_helper"

RSpec.describe AirQualityFacade do
  describe "class methods" do
    describe "::air_quality_in" do
      it "returns an air quality object for a specific capital", :vcr do
        query = "Abuja"
        air_quality = AirQualityFacade.new.air_quality_in(query)

        expect(air_quality).to be_an(AirQuality)
        expect(air_quality.aqi).to be_a(Float)
        expect(air_quality.pm25_concentration).to be_a(Float)
        expect(air_quality.co_concentration).to be_a(Float)
      end
    end
  end
end
