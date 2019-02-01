class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true 
    validates :password_digest, presence: true 
    validates_length_of :password, minimum: 6, allow_nil: true
    validates :session_token, presence: true, uniqueness: true
    
    after_initialize :ensure_session_token

    def ensure_session_token 
      self.session_token ||= SecureRandom.urlsafe_base64
    end

    def resset_session_token! 
       self.session_token = nil 
       ensure_session_token
       self.save!
       self.session_token 
    end
    
    attr_reader :password

    def password=(password)
      self.password_digest = BCrypt::Password.create(password)
      @password = password 
    end  
    
    def is_password?(password)
     BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def self.find_by_credentials(user_params)
        user = User.find_by(email: user_params[:email])
        if user && user.is_password?(user_params[:password])
            user 
        else 
            nil 
        end
    end
end
