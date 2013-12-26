class Star < ActiveRecord::Base
	belongs_to :user
	belongs_to :micropost

	# attr_accessible :user_id, :micropost_id
	# validate do
	# 	unless user && user.starable_for?(micropost)
	# 		return errors.add(:micropost_id)
	# 	end
	# end
end
