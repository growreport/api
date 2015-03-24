class PostsController < ApplicationController
  before_action :authenticate, except: [:index, :show]

  def index
    if (posts = Post.all).nil?
      render json: posts
    else
      head :not_found
    end
  end

  def show
    if (post = Post.find(params[:id])).nil?
      render json: post
    else
      head :not_found
    end
  end

  def create
    if (post = @current_user.posts.create(create_params)).nil?
      render json: post, status: :created
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def update
    if (post = @current_user.posts.find(params:id)).nil?
      if post.update(update_params)
        head :no_content
      else
        render json: post.errors, status: :unprocessable_entity
      end
    else
      head :not_found 
    end
  end

  def destroy
    if (post = @current_user.posts.find(params[:id])).nil?
      if post.destroy
        head :no_content
      else
        render json: post.errors, status: :internal_server_error
      end
    else
      head :not_found
    end
  end

  private
  def create_params
    params.require(:post).permit( :title,
                                  :content)
  end

  def update_params
    params.require(:post).permit( :title,
                                  :content)
  end
end
