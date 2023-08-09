module Api
  module V1
    class FavoritesController < ApplicationController
      before_action :find_user

      def index
        if @user.present?
          render json: FavoritesSerializer.new(@user.favorites), status: :ok
        else
          render json: ErrorSerializer.new("User credentials invalid").credential_errors, status: :unauthorized
        end
      end

      def create
        if @user.present?
          @user.favorites.create!(favorite_params)
          render json: { success: "Favorite added successfully" }, status: :created
        else
          render json: ErrorSerializer.new("User credentials invalid").credential_errors, status: :unauthorized
        end
      end

      private

      def find_user
        @user = User.find_by(api_key: params[:api_key])
      end

      def favorite_params
        params.permit(:country, :recipe_link, :recipe_title)
      end
    end
  end
end
