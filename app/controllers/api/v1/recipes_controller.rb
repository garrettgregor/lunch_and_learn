module Api
  module V1
    class RecipesController < ApplicationController
      def index
        if params[:country] == ""
          random_country = CountryFacade.new.random_country
          recipes = RecipeFacade.new.recipes_by_country(random_country.name)
          render json: RecipeSerializer.new(recipes), status: :ok
        else
          recipes = RecipeFacade.new.recipes_by_country(params[:country])
          render json: RecipeSerializer.new(recipes), status: :ok
        end
      end
    end
  end
end
