class CountryFacade
  def capital_of(country)
    capital_data = service.capital_of(country)

    @city = Capital.new(capital_data.first)
  end

  def random_country
    countries_data = service.country_names

    @random = countries_data.map do |country_data|
      Country.new(country_data)
    end.sample
  end

  private

  def service
    CountryService.new
  end
end
