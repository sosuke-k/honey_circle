class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  helper_method :get_newsfeed
  def get_newsfeed
  	arr = []
  	returnedArr = []
  	begin
  		(0..9).each{|i|
  			arr.push(Micropost.all[i])
  			arr.push(Star.all[-i-1])
  			arr.push(Interest.all[-i-1])
  			arr.push(Comment.all[-i-1])
  		}
  		arr.sort_by!{|obj| obj.updated_at}
  		arr.reverse!
  		(0..9).each{|i| returnedArr.push(arr[i]) }
  		return returnedArr
  	rescue
  		return []
  	end
  end


  	helper_method :current_user
  	private

	  	def current_user
	  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	  	end



  end
