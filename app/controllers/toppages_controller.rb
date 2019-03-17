class ToppagesController < ApplicationController
  def index
    if logged_in?
      @hatapost = current_user.hataposts.build
      @hataposts = current_user.hataposts.order('created_at DESC').page(params[:page])
    end 
  end
end
