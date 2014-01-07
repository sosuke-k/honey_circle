class MicropostsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy

	def create
		@micropost = current_user.microposts.build(micropost_params)
		# @micropost.detail = @micropost.detail.gsub(/(\r\n?)|(\n)/, "<br>")
		if @micropost.save
			require 'twitter'
			client = Twitter::REST::Client.new do |config|
				config.consumer_key       = ENV['consumer_key']
				config.consumer_secret    = ENV['consumer_secret']
				config.oauth_token        = ENV['oauth_token']
				config.oauth_token_secret = ENV['oauth_token_secret']
			end
			tweet = @micropost.user.name
			tweet += " さんが投稿しました: 「"
			tweet += @micropost.content
			tweet += "」"
			if @micropost.detail?
				tweet += "(詳細文あり) "
			end
			#記事へのリンク
			# tweet += http://127.0.0.1:3000/microposts/
			# tweet += @micropost.id
			# tweet += ' '
			tweet = (tweet.length > 140) ? tweet[0..139].to_s : tweet
			begin
				client.update(tweet)
			rescue Exception => e
				p e
			end

			flash[:success] = "Micropost created!"
			redirect_to root_url
		else
			@feed_items = []
			render 'static_pages/home'
		end
	end

	def show
		@micropost = Micropost.find(params[:id])
		@comments = @micropost.comments.paginate(page: params[:page])
		@comment = current_user.comments.build if signed_in?
		# respond_to do |format|
		# 	format.json {render :json => @micropost, :status => 201 }
		# end
	end

	def destroy
		@micropost.destroy
		redirect_to root_url
	end

	private

		def micropost_params
			params.require(:micropost).permit(:content, :detail)
		end
		def correct_user
			@micropost = current_user.microposts.find_by(id: params[:id])
			redirect_to root_url if @micropost.nil?
		end
end