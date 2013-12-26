class Micropost < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	default_scope -> { order('created_at DESC') }
	validates :content, presence: true, length: { maximum: 140 }
	validates :user_id, presence: true

	has_many :stars, :dependent => :destroy
	has_many :stared_users, :through => :stars, :source => :user
end
