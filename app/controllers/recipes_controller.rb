class RecipesController < ApplicationController

    # GET '/recipes'
    def index
        user = User.find_by(id: session[:user_id])
        if user
            recipe = Recipe.all
            render json: recipe, status: 201
        else
            render json: { errors: ["Unauthorized", "Login to view"]}, status: 401
        end
    end

    # POST '/recipes'
    def create
        user = User.find_by(id: session[:user_id])
        if user
            recipe = user.recipes.create(recipe_params)
            if recipe.valid?
                render json: recipe, status: 201
            else
                render json: { errors: ["Not valid", "Unprocessable Entity"]}, status: 422
            end
        else
            render json: { errors: ["Unauthorized", "Login to create recipe"]}, status: 401
        end
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
