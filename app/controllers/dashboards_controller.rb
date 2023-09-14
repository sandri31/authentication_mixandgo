class DashboardsController < ApplicationController
  def index
    user = User.find_by(id: session[:user_id])
    redirect_to posts_path unless user
  end
end
