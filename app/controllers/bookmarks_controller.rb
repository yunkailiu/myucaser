class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)
    if @bookmark.save
      @post = @bookmark.post
      @is_bookmarked = @bookmark
      respond_to :js
    else
      flash[:alert] = "操作出错，请稍等 ..."
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @post = @bookmark.post
    if @bookmark.destroy
      respond_to :js
    else
      flash[:alert] = "操作出错，请稍等 ..."
    end
  end

  private
  def bookmark_params
    params.permit :user_id, :post_id
  end
end
