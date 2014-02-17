class Micropost < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	acts_as_paranoid
	default_scope -> { order('created_at DESC') }
	validates :content, presence: true, length: { maximum: 80 }
	validates :detail, length: { maximum: 65535 }
	validates :user_id, presence: true

	has_many :stars, :dependent => :destroy
	has_many :stared_users, :through => :stars, :source => :user
	has_many :interests, :dependent => :destroy
	has_many :interested_users, :through => :interests, :source => :user
	has_many :comments, :dependent => :destroy
	#has_many :stared_users, :through => :stars, :source => :user
end
