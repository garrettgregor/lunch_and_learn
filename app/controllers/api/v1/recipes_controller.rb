module Api
  module V1
    class RecipesController < ApplicationController
      def index
        if params[:country].blank?
          country = CountryFacade.new.random_country.name
          recipes = RecipeFacade.new.recipes_by_country(country)
        else
          recipes = RecipeFacade.new.recipes_by_country(params[:country])
        end
        render json: RecipeSerializer.new(recipes), status: :ok
      end
    end
  end
end
