class SessionsController < ApplicationController

	def new
	end

	def create
		# user = User.find_by(email: params[:session][:email].downcase)
		# if user && user.authenticate(params[:session][:password])
		# 	sign_in user
		# 	redirect_back_or user
		# else
		# 	flash.now[:error] = 'Invalid email/password combination'
		# 	render 'new'
		# end
		auth = request.env["omniauth.auth"]
		user = User.find_by(provider: 'twitter', uid: auth["uid"]) || User.create_with_omniauth(auth)
		session[:user_id] = user.id
		redirect_to root_url, :notice => "Signed in!"
	end

	def destroy
		# sign_out
		session[:user_id] = nil
		redirect_to root_url, :notice => "Signed out!"
	end
end