require "rails_helper"

RSpec.describe CountryService do
  describe "class methods" do
    describe "::country_names" do
      it "returns a list of countries", :vcr do
        results = CountryService.new.country_names

        expect(results).to be_an(Array)

        results.each do |result|
          expect(result).to have_key(:name)
          expect(result[:name]).to have_key(:common)
        end
      end
    end

    describe "::capital_of" do
      context "happy path" do
        it "returns a Nigeria's capital as a list", :vcr do
          query = "Nigeria"
          result = CountryService.new.capital_of(query)

          expect(result).to be_an(Array)

          capital = result.first

          expect(capital).to have_key(:capital)
          expect(capital[:capital]).to be_an(Array)
          expect(capital[:capital].first).to eq("Abuja")
        end

        it "returns a France's capital as a list", :vcr do
          query = "France"
          result = CountryService.new.capital_of(query)

          expect(result).to be_an(Array)

          capital = result.first

          expect(capital).to have_key(:capital)
          expect(capital[:capital]).to be_an(Array)
          expect(capital[:capital].first).to eq("Paris")
        end
      end
    end
  end
end
