class CountryFacade
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
