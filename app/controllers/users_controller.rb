class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.search(params[:term])
    respond_to :js
  end
  
  def show
    @user = User.find(params[:id])
    set_meta_tags title: @user.name
    @posts = @user.posts.includes(:photos, :likes, :comments)
    @saved = Post.joins(:bookmarks).where("bookmarks.user_id=?", current_user.id).
      includes(:photos, :likes, :comments) if @user == current_user
    @liked = Post.joins(:likes).where("likes.user_id=?", current_user.id).
      includes(:photos, :likes, :comments) if @user == current_user
  end
  
  #确保是正确的用户
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  def following
    @title = "已关注的人"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def followers
    @title = "全部粉丝"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
end
