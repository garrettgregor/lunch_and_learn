module Api
  module V1
    class RecipesController < ApplicationController
      def index
        recipes = RecipeFacade.new.recipes_by_country(params[:country])
        render json: RecipeSerializer.new(recipes)
      end
    end
  end
end
