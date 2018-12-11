class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:show, :destroy]

  def index
    @posts = Post.all.limit(10).includes(:photos, :user).order("created_at desc")
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      if params[:images]
        params[:images].each do |img|
         @post.photos.create(image: params[:images][img])
        end
      end

      redirect_to posts_path
      flash[:notice] = "发布成功！"
    else
      flash[:alert] = "发布失败！"
      redirect_to posts_path
    end
  end

  def show
    @posts = @post.photos
  end
  
  def destroy
    if @post.user == current_user
      if @post.destroy
        flash[:notice] = "动态已被删除！"
      else
        flash[:alert] = "动态删除失败！"
      end
    else
      flash[:notice] = "您无该权限！"
    end
    redirect_to root_path
  end


  private

  def find_post
    @post = Post.find_by id: params[:id]

    return if @post
    flash[:danger] = "动态不存在！"
    redirect_to root_path
  end

  def post_params
    params.require(:post).permit :content
  end
end
