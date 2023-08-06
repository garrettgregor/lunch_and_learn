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
  end
end
