class User < ApplicationRecord
	has_many :timesheets

	validates :username, presence: true, format: {with: /\A[a-zA-Z0-9_]*\z/, message: "The user name should be of one word. It should not include spaces, special characters."}
	validates :username, uniqueness: true
end
