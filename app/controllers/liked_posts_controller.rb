class LikedPostsController < ApplicationController
  def create
    hatapost = Hatapost.find(params[:hatapost_id])
    current_user.liked(hatapost)
    flash[:success] = 'お気に入りに登録しました。'
    redirect_to root_url
  end

  def destroy
    hatapost = Hatapost.find(params[:hatapost_id])
    current_user.unliked(hatapost)
    flash[:success] = 'お気に入り登録を解除しました。'
    redirect_to root_url
  end
end
