class ToppagesController < ApplicationController
  def index
    if logged_in?
      @hatapost = current_user.hataposts.build
      @hataposts = current_user.feed_hataposts.order('created_at DESC').page(params[:page]).per(5)
    end 
  end
end
