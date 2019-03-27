class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :followings, :likes, :edit, :update]
  
  
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @hataposts = @user.hataposts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end 
  end
  
  def edit
    @user = User.find(params[:id])
  end 
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
        flash[:success] = 'プロフィールは正常に更新されました'
        redirect_to root_url
    else 
        flash.now[:danger] = 'プロフィールは正常に更新されませんでした'
        render :edit
    end 
  end 
  
  def destroy
    @user = User.find(params[:id])
    
    if @user.destroy
      flash[:success] = '退会しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '退会できませんでした。'
      redirect_to root_url
    end 
  end 
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end 
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end 
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.page(params[:page])
    counts(@user)
  end 

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end 
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end 
end 
