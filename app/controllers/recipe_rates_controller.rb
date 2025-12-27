class RecipeRatesController < ApplicationController
    def create
        recipe = Recipe.find(params[:recipe_id])
        rate = current_user.recipe_rates.new(recipe_rate_params)
        rate.recipe_id = recipe.id
        if rate.save
          flash[:notice] = "評価の投稿に成功しました。"
          redirect_to recipe_path(recipe.id)
        else
          flash[:notice] = "評価の投稿に失敗しました。"
          redirect_to recipe_path(recipe.id)
       end
    end

    private
    def recipe_rate_params
        params.require(:recipe_rate).permit(:rate)
    end
end
