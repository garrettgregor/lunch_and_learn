module Api
  module V1
    class LearningResourcesController < ApplicationController
      def index
        # Refactor: fix bugs for regex errors
        # Below is close, but doesn't work for Åland Islands
        ## query = params[:country].chars.map { |char| char.ascii_only? ? char : CGI.escape(char) }.join
        if params[:country].blank?
          country = CountryFacade.new.random_country.name
          video = VideoFacade.new.video_resources(country)
          photos = PhotoFacade.new.photos_from(country)
        else
          country = params[:country]
          video = VideoFacade.new.video_resources(params[:country])
          photos = PhotoFacade.new.photos_from(params[:country])
        end
        render json: LearningResourcesSerializer.serialize(country, video, photos), status: :ok
      end
    end
  end
end
