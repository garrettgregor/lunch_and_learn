require "rails_helper"

RSpec.describe AirQualityService do
  describe "class methods" do
    describe "::air_quality_in" do
      context "happy path" do
        it "returns the air quality for a specific country", :vcr do
          query = "Abuja"
          results = AirQualityService.new.air_quality_in(query)

          expect(results).to be_a(Hash)

          expect(results).to have_key(:"PM2.5")
          expect(results[:"PM2.5"]).to have_key(:concentration)
          expect(results[:"PM2.5"][:concentration].to_f).to be_an(Float)

          expect(results).to have_key(:CO)
          expect(results[:CO]).to have_key(:concentration)
          expect(results[:CO][:concentration].to_f).to be_a(Float)

          expect(results).to have_key(:overall_aqi)
        end
      end
    end
  end
end
