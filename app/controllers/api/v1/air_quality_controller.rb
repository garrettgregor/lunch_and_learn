module Api
  module V1
    class AirQualityController < ApplicationController
      def index
        if params[:country] == ""
          random_country = CountryFacade.new.random_country
          capital = CountryFacade.new.capital_of(random_country.name)
          air_quality = AirQualityFacade.new.air_quality_in(capital.name)
        else
          capital = CountryFacade.new.capital_of(params[:country])
          air_quality = AirQualityFacade.new.air_quality_in(capital.name)
        end
        render json: AirQualitySerializer.serialize(capital, air_quality), status: :ok
      end
    end
  end
end
