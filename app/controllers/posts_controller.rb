class PostsController < ApplicationController
  before_filter :authenticate_user!, except: :public_feed

  def feed
    @posts = current_user.feed_posts
  end

  def public_feed
    @posts = Post.last(30).reverse
  end

  def create
  	@post = current_user.posts.create(params[:post].permit(:text))
		@posts = current_user.feed_posts
		respond_to do |format|
      format.html { redirect_to feed_posts_path }
			format.js
		end
  end

  def destroy
  	@post = Post.find(params[:id])
  	@post.destroy if @post.user == current_user
  	@posts = current_user.feed_posts
  	respond_to do |format|
      format.html { redirect_to feed_posts_path }
	  	format.js
  	end
  end
end
