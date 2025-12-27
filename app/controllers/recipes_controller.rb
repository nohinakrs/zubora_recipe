class RecipesController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @recipes = Recipe.all.order(params[:sort])
    @user = current_user
  end

  def new
    @recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
    if @recipe.user_id != current_user.id
    redirect_to user_path
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
    @user =  current_user
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @user = current_user
    @recipe.user_id = current_user.id
    
    if @recipe.save
      flash[:notice] = "レシピの保存を完了しました。"
      redirect_to recipe_path(@recipe.id)
    else
      @recipes = Recipe.all
      render :new
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
     flash[:notice] = "レシピの更新が完了しました。"
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
    params.require(:recipe).permit(:recipe_name, :recipe, :image, :tag_names)
  end

  def is_matching_login_user
    recipe = Recipe.find(params[:id])
    unless recipe.user.id == current_user.id
      redirect_to recipes_path
    end
  end
end
