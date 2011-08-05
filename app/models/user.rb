class User < ActiveRecord::Base
	validates :name, :presence => true, :uniqueness => true

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
       
  #Get user's allowed requests uri  
=begin 
  def permission_urls   
     user_urls = {"/products/index",
                  "/products/edit",
                  "/products/show",
                  "/products/new",
                  "/carts/index",
                  "/carts/edit",
                  "/carts/show",
                  "/carts/new",
                  "/line_items/index",
                  "/line_items/edit",
                  "/line_items/show",
                  "/line_items/new",
                  "/orders/index",
                  "/orders/edit",
                  "/orders/show",
                  "/orders/new",
                  "/users/index",
                  "/users/edit",
                  "/users/show",
                  "/admin/index"}    
  end  
=end

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
