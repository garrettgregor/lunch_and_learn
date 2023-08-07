class CountryService
  def country_names
    get_url("v3.1/all?fields=name")
  end

  def capital_of(country)
    get_url("v3.1/name/#{country}?fields=capital")
  end

  private

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://restcountries.com/")
  end
end
