class Book < ApplicationRecord
	belongs_to :user
	validates :title, :body, presence: true
	validates :body, length: { maximum: 200 }

	def user
	  return User.find_by(id: self.user_id)
	end
end

