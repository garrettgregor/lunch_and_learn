module Api
  module V1
    class AirQualityController < ApplicationController
      def index
        country = (params[:country].presence || CountryFacade.new.random_country.name)
        capital = CountryFacade.new.capital_of(country)
        air_quality = AirQualityFacade.new.air_quality_in(capital.name)
        render json: AirQualitySerializer.serialize(capital, air_quality), status: :ok
      end
    end
  end
end
