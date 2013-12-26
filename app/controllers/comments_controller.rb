class CommentsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy

	def create

		@comment = current_user.comments.build(comment_params)
		@micropost = @comment.micropost
		if @comment.save
			flash[:success] = "comment created!"
			redirect_to @micropost
		else
			@comment_items = []
			render 'static_pages/home'
		end
	end

	def destroy
		@comment.destroy
		redirect_to root_url
	end

	private

		def comment_params
			params.require(:comment).permit(:content,:micropost_id)
		end
		def correct_user
			@comment = current_user.comments.find_by(id: params[:id])
			redirect_to root_url if @comment.nil?
		end
end