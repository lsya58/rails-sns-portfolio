class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if params[:user][:current_password].present?
      if @user.authenticate(params[:user][:current_password])
        if @user.update(password: params[:user][:password], 
                       password_confirmation: params[:user][:password_confirmation])
          flash[:success] = "パスワードを変更しました"
          redirect_to settings_path
        else
          render 'static_pages/settings', status: :unprocessable_entity
        end
      else
        @user.errors.add(:current_password, "が正しくありません")
        render 'static_pages/settings', status: :unprocessable_entity
      end
    else
      if @user.update(user_params_for_update)
        flash[:success] = "プロフィールを更新しました"
        redirect_to @user
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "アカウントを削除しました"
    redirect_to root_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_params_for_update
    params.require(:user).permit(:name, :email, :avatar)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end