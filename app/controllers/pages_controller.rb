class PagesController < ApplicationController
  def home
  	@recent_posts = Post.last(3).reverse
  end
end
