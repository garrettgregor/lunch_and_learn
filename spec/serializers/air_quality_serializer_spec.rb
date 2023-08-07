require "rails_helper"

RSpec.describe AirQualitySerializer do
  it "should serialize air quality for Nigeria", :vcr do
    country = "Nigeria"
    capital = CountryFacade.new.capital_of(country)
    air_quality = AirQualityFacade.new.air_quality_in(capital.name)
    response = AirQualitySerializer.serialize(capital, air_quality)

    expect(response).to have_key(:data)
    expect(response[:data]).to be_a(Hash)
    expect(response[:data][:id]).to be(nil)
    expect(response[:data][:type]).to eq("air_quality")
    expect(response[:data][:city]).to eq("Abuja")
    expect(response[:data][:attributes]).to be_a(Hash)

    attributes = response[:data][:attributes]

    expect(attributes[:aqi]).to be_a(Float)
    expect(attributes[:pm25_concentration]).to be_a(Float)
    expect(attributes[:co_concentration]).to be_a(Float)
  end
end
