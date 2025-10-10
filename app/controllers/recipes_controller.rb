class RecipesController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @recipe = Recipe.all
    @user = current_user
  end

  def new
    @newrecipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
    if @recipe.user_id != current_user.id
    redirect_to user_path
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user =  current_user
  end

  def create
    @newrecipe = Recipe.new(recipe_params)
    @user = current_user
    @newrecipe.user_id = current_user.id
    if @newrecipe.save
      flash[:notice] = "You have created book successfully."
      redirect_to recipe_path(@newrecipe.id)
    else
      @recipes = recipe.all
      render :index
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
     flash[:notice] = "You have updated book successfully."
     redirect_to recipe_path(@recipe.id)
    else
      render "edit"
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    if recipe.destroy
      redirect_to '/recipes'
    end
  end

  private
  
  def recipe_params
    params.require(:recipe).permit(:recipe_name, :recipe, :image)
  end

  def is_matching_login_user
    recipe = Recipe.find(params[:id])
    unless recipe.user.id == current_user.id
      redirect_to recipes_path
    end
  end
end
