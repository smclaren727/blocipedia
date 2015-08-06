class User < ActiveRecord::Base
	has_many :wikis
	after_create :initialize_user
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
	def initialize_user
		update_attributes(role: 'standard')
	end

	def standard?
		role == 'standard'
	end		

	def premium?
		role == 'premium'
	end

	def admin?
		role == 'admin'
	end

	def upgrade_to_premium
		self.role = 'premium'
		save
	end

	def downgrade_to_standard_and_save
		self.role = 'standard'
		save
	end
end
