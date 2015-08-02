class User < ActiveRecord::Base
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
	def user?
		role == 'user'
	end		

	def member?
		role == 'member'
	end

	def admin?
		role == 'admin'
	end

end
