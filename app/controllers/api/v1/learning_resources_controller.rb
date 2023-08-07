module Api
  module V1
    class LearningResourcesController < ApplicationController
      def index
        # if params[:country] == ""
        #   random_country = CountryFacade.new.random_country
        #   recipes = RecipeFacade.new.recipes_by_country(random_country.name)
        # else
        #   recipes = RecipeFacade.new.recipes_by_country(params[:country])
        # end
        video = VideoFacade.new.video_resources(params[:country])

        render json: LearningResourcesSerializer.new(video), status: :ok
      end
    end
  end
end
