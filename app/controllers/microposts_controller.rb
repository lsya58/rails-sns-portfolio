class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "投稿を作成しました"
      redirect_to root_url
    else
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    if @micropost
      @micropost.destroy
      flash[:success] = "投稿を削除しました"
    else
      flash[:danger] = "削除権限がありません"
    end
    redirect_to root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end
end