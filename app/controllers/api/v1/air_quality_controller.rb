module Api
  module V1
    class AirQualityController < ApplicationController
      def index
        capital = CountryFacade.new.capital_of(params[:country])
        air_quality = AirQualityFacade.new.air_quality_in(capital.name)

        render json: AirQualitySerializer.serialize(capital, air_quality), status: :ok
      end
    end
  end
end
