class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def show
     @user = User.find(params[:id])
     @recipe = @user.recipe
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

  def withdrawal
    @user = User.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
