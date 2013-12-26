class StarController < ApplicationController
	before_action :set_micropost
	def toggle_star
		@starsArray = Star.find(:all, :conditions => { :user_id => current_user.id, :micropost_id => @micropost.id })
		if @starsArray == [] #まだStarが付いていなければ
			@star = stars.new(:user_id => current_user.id, :micropost_id => @micropost.id)

			respond_to do |format|
				if @star.save
					format.html { redirect_to @micropost, notice: 'star was successfully created.' }
					format.json { head :no_content }
				else
					format.html { render text: @star.errors.full_messages, status: :unprocessable_entity }
					format.json { render json: @star.errors, status: :unprocessable_entity }
				end
			end
		else
			@starsArray.each{|s| s.destroy}
		end

	end

# スターを追加
def add_star(postobj)
	# current_user.stared_posts << postobj
	@star = Star.new({id:1,user_id:1,micropost_id:1})
	@star.save
	return { :json => { :type => "add", :result => "success" } }
end

#スターを削除
def remove_star(postobj)
	current_user.stared_posts.delete(postobj)
	return { :json => { :type => "remove", :result => "success" } }
end

private
def set_micropost
	@micropost = Micropost.find(params[:micropost_id])
end

def stars
	current_user.stars.where(micropost_id: @micropost.id)
end
def star_params
	value = params.require(:star)
	value.is_a?(Hash) ? value : { value: value }
end

end
