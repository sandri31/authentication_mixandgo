class PostsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :require_author, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]

    if @post.save
      redirect_to posts_path, notice: "You have successfully created a post."

    else
      flash[:alert] = "Couldn't save the post! Please check the errors below. Errors: " + @post.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if @post.update(post_params)
      redirect_to dashboards_path, notice: "You have successfully updated the post."
    else
      flash[:alert] = "Couldn't update the post!"
      render :edit, status: :unprocessable_entity
    end

    def destroy
      @post.destroy
      redirect_to dashboards_path, notice: "You have successfully deleted the post."
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end

    def require_login
      unless session[:user_id]
        flash[:alert] = "Please login to continue."
        redirect_to new_login_path
      end
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def require_author
      unless @post.user_id == session[:user_id]
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to dashboards_path
      end
    end
end
