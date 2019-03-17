class HatapostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :edit, :update]
  
  def create
    @hatapost = current_user.hataposts.build(hatapost_params)
    if @hatapost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else 
      @hataposts = current_user.hataposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end 
  end

  def destroy
    @hatapost.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def edit
    @hatapost = Hatapost.find(params[:id])
  end 
  
  def update
    @hatapost = Hatapost.find(params[:id])
    
    if @hatapost.update(hatapost_params)
        flash[:success] = '投稿は正常に更新されました'
        redirect_to root_url
    else 
        flash.now[:danger] = '投稿は正常に更新されませんでした'
        render :edit
    end 
  end 
  
  private
  
  def hatapost_params
    params.require(:hatapost).permit(:content)
  end 
  
  def correct_user
    @hatapost = current_user.hataposts.find_by(id: params[:id])
    unless @hatapost
    redirect_to root_url
    end 
  end 
end

