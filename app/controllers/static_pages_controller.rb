class StaticPagesController < ApplicationController
  def home
<<<<<<< HEAD
  	if signed_in?
  	  @micropost = current_user.microposts.build
  	  @feed_items = current_user.feed.paginate(page: params[:page])
  	end
=======
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
>>>>>>> updating-users
  end

  def help
  end

  def about
  end
end
