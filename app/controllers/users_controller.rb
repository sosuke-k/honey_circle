class UsersController < ApplicationController
	# before_action :signed_in_user, only: [:index, :edit, :update]
	before_action :signed_in_user, only: [:edit, :update]
	before_action :correct_user,   only: [:edit, :update]
	before_action :admin_user,     only: :destroy

	def index
		@users = User.paginate(page: params[:page])
	end

	def show
		if params[:id]
			@user = User.find(params[:id])
		elsif params[:user_nickname]
			@user = User.where(nickname:"#{params[:user_nickname]}").first
		end
		@feed_items = @user.microposts.paginate(page: params[:page])
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			render 'new'
		end
	end


	def new
		@user = User.new
	end

	def edit
	end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def check_notification
		current_user.update_attribute('last_checked',Time.now)
		respond_to do |format|
			format.json {render json:
				{:action => "add", :result => "success", :user => current_user.name }
			}
		end
	end

	private
		#
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
		# Before actions
		def signed_in_user
			unless signed_in?
				store_location
				redirect_to signin_url, notice: "Please sign in."
			end
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
	end
