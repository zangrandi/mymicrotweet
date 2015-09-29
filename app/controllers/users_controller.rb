class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:unfollow, :notifications]

  def show
  	@user = User.find_by(username: params[:id])
    @posts = @user.posts
  end

  def index
    @users = User.all
  end

  def follow
    if user_signed_in?
      @user = User.find_by(username: params[:id])
      current_user.add_publisher(@user)
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      redirect_to new_user_registration_path
    end
  end

  def unfollow
    @user = User.find_by(username: params[:id])
    current_user.publishers.delete(@user)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :follow }
    end
  end

  def notifications
    @user = current_user
    @notifications = @user.notifications
    @notifications.each do |notification|
      notification.update_attribute :read, true
    end
  end

  def search
    @users = User.where("username LIKE ?", "%#{params[:search][:text]}%")
    respond_to do |format|
      format.html { render :index }
      format.js
    end    
  end
end
