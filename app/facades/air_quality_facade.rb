class AirQualityFacade
  def air_quality_in(city)
    results = service.air_quality_in(city)

    @air_quality = AirQuality.new(results)
  end

  private

  def service
    AirQualityService.new
  end
end
