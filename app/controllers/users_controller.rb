class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def show
     @user = User.find(params[:id])
     @recipe = Recipe.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
      if @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
       redirect_to user_path(@user.id)
      else
        render "edit"
      end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_imageimage)
  end
end
