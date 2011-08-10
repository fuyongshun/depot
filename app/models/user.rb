class User < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  
	ROLE_TYPES = ["Administrator","Register_User"]
  
  validates :name,  :presence => true,
                    :uniqueness => true,
                    :length => {:minimum => 1, :maximum => 254} 
                    
  validates :email, :presence => true,  
                    :length => {:minimum => 3, :maximum => 254}, 
                    :uniqueness => true, 
                    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i} 

	validates :password, :confirmation => true
	attr_accessor :password_confirmation
	attr_reader :password

	validate :password_must_be_present

	after_destroy :ensure_an_admin_remains

	def ensure_an_admin_remains
		if User.count.zero?
			raise "Can't delete last user"
		end
	end
       
  #user management------------
  def is_admin
    role == 'Administrator'
  end
  
  def is_user
    role == 'Register_User'
  end
  
  #------------------

	class << self
		def authenticate(name, password)
			if user = find_by_name(name)
				if user.hashed_password == encrypt_password(password, user.salt)
					user
				end
			end
		end

		def encrypt_password(password, salt)
			Digest::SHA2.hexdigest(password + "wibble" + salt)
		end
	end
	
	def password=(password)
		@password = password

		if password.present?
			generate_salt
			self.hashed_password = self.class.encrypt_password(password, salt)
		end
	end

	private
		def password_must_be_present
			errors.add(:password, "Missing password") unless hashed_password.present?
		end

		def generate_salt
			self.salt = self.object_id.to_s + rand.to_s
		end
end
