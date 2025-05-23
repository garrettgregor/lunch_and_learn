module Api
  module V1
    class LearningResourcesController < ApplicationController
      def index
        # Refactor: fix bugs for regex errors
        # Below is close, but doesn't work for Åland Islands
        ## query = params[:country].chars.map { |char| char.ascii_only? ? char : CGI.escape(char) }.join
        # refactor to a LearningResourcesFacade?
        country = params[:country].presence || CountryFacade.new.random_country.name
        video = VideoFacade.new.video_resources(country)
        photos = PhotoFacade.new.photos_from(country)

        if video == {}
          render json: LearningResourcesSerializer.serialize_no_videos(country), status: :ok
        else
          render json: LearningResourcesSerializer.serialize(country, video, photos), status: :ok
        end
      end
    end
  end
end
