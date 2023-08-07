class PhotoFacade
  def photos_from(country)
    results = service.photos_from(country)

    @photos = results[:results].map { |details| Photo.new(details) }
  end

  private

  def service
    PhotoService.new
  end
end
