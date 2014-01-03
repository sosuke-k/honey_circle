class StaticPagesController < ApplicationController
	def home
		if current_user
			@micropost = current_user.microposts.build if signed_in?
			@feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
			@comment_items = Comment.all.paginate(page: params[:page])
		end
	end
	def help
	end

	def about
	end

	def contact
	end


	def api
		microposts = Micropost.all
		respond_to do |format|
			format.json {render :json => microposts}
		end
	end
end
