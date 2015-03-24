class CommentsController < ApplicationController
  before_action :authenticate, except: [:index, :show]

  def index
    if (posts = Post.find(params[:post_id]).comments).nil?
      render json: posts
    else
      head :not_found
    end
  end

  def show
    if (comment = Post.find(params[:post_id]).comments.find(params[:id])).nil?
      render json: comment
    else
      head :not_found
    end
  end

  def create
    if (comment = @current_user.comments.create(create_params)).nil?
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if (comment = @current_user.comments.find(params[:id])).nil?
      if comment.update(update_params)
        head :no_content
      else
        render json: comment.errors, status: :unprocessable_entity
      end
    else
      head :not_found
    end
  end

  def destroy
    if (comment = @current_user.comments.find(params[:id])).nil?
      if comment.destroy
        head :no_content
      else
        render json: comment.errors, status: :internal_server_error
      end
    else
      head :not_found
    end
  end

  private
  def create_params
    params.require(:comment).permit(:post_id,
                                    :content)
  end

  def update_params
    params.require(:comment).permit(:content)
  end
end
