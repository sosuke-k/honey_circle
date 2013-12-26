class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :micropost
	validates :content, presence: true, length: { maximum: 140 }
	validates :user_id, presence: true
end
