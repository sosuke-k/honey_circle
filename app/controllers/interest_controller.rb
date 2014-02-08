class InterestController < ApplicationController
	before_action :set_micropost
	def toggle_interest
		@interestsArray = Interest.find(:all, :conditions => { :user_id => current_user.id, :micropost_id => @micropost.id })
		if @interestsArray == [] #まだInterestが付いていなければ
			@interest = interests.new(:user_id => current_user.id, :micropost_id => @micropost.id)

			respond_to do |format|
				if @interest.save
					format.json {render json: {:action => "add", :result => "success", :user => current_user.name, :micropost_id => @interest.micropost.id }}
				else
					format.html { render text: @interest.errors.full_messages, status: :unprocessable_entity }
					format.json { render json: @interest.errors, status: :unprocessable_entity }
				end
			end
		else
			@interestsArray.each{|s|
				s.destroy
				respond_to do |format|
					format.json {render :json => {:action => "remove", :result => "success", :user => current_user.name, :micropost_id => s.micropost.id  }}
				end
			}
		end

	end

# スターを追加
def add_interest(postobj)
	# current_user.interested_posts << postobj
	@interest = Interest.new({id:1,user_id:1,micropost_id:1})
	@interest.save
	return { :json => { :type => "add", :result => "success" , :user => current_user.name }}
end

#スターを削除
def remove_interest(postobj)
	current_user.interested_posts.delete(postobj)
	return { :json => { :type => "remove", :result => "success" , :user => current_user.name }}
end

private
def set_micropost
	@micropost = Micropost.find(params[:micropost_id])
end

def interests
	current_user.interests.where(micropost_id: @micropost.id)
end
def interest_params
	value = params.require(:interest)
	value.is_a?(Hash) ? value : { value: value }
end

end
