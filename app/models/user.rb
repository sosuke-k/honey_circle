class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :stars, :dependent => :destroy
	has_many :stared_posts, :through => :stars, :source => :micropost
	has_many :interests, :dependent => :destroy
	has_many :interested_posts, :through => :interests, :source => :micropost
	acts_as_paranoid
	def starable_for?(micropost)
		micropost && micropost.user != self && !stars.exists?(:micropost_id => micropost.id)
	end
	# before_save { self.email = email.downcase }
	# before_create :create_remember_token
	# validates(:name, presence: true, length: {maximum: 50})
	# VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	# validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	# has_secure_password
	# validates(:password, length: {minimum: 6})

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def feed
	    # このコードは準備段階です。
	    # 完全な実装は第11章「ユーザーをフォローする」を参照してください。
	    # Micropost.where("user_id = ?", id)
	    Micropost.all
	end

	def self.create_with_omniauth(auth)
		create! do |user|
			user.provider = auth["provider"]
			user.uid = auth["uid"]
			user.name = auth["info"]["name"]
			user.nickname = auth.info['nickname']
			user.image = auth.info['image']
		end
	end

	private

	def create_remember_token
		self.remember_token = User.encrypt(User.new_remember_token)
	end
end
