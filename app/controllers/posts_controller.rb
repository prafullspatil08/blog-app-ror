# app/controllers/posts_controller.rb
class PostsController < ApplicationController
    before_action :set_post, only: %i[show update destroy]

    def index
      @posts = Post.accessible_by(current_ability)
      render json: @posts
    end

    def show
      authorize! :read, @post
      render json: @post
    end

    def create
      @post = current_user.posts.build(post_params)
      authorize! :create, @post
      @post.save ? render(json: @post, status: :created) : render(json: @post.errors, status: :unprocessable_entity)
    end

    def update
      authorize! :update, @post
      @post.update(post_params) ? render(json: @post) : render(json: @post.errors, status: :unprocessable_entity)
    end

    def destroy
      authorize! :destroy, @post
      @post.destroy
      head :no_content
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end
end
