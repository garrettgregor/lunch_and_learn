require "rails_helper"

RSpec.describe CountryFacade do
  describe "class methods" do
    describe "::random_country" do
      it "returns a random country", :vcr do
        country = CountryFacade.new.random_country

        expect(country).to be_a(Country)
        expect(country.name).to be_a(String)
      end
    end

    describe "::capital_of" do
      it "returns a Nigeria's capital", :vcr do
        query = "Nigeria"
        capital = CountryFacade.new.capital_of(query)

        expect(capital).to be_a(Capital)
        expect(capital.name).to eq("Abuja")
      end

      it "returns a France's capital", :vcr do
        query = "France"
        capital = CountryFacade.new.capital_of(query)

        expect(capital).to be_a(Capital)
        expect(capital.name).to eq("Paris")
      end
    end
  end
end
