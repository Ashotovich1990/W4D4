class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?
    def login(user)
        session[:session_token] = user.resset_session_token!  
    end

    def current_user 
       @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in? 
        # @current_user.nil?
        !!current_user
    end

    def log_out!
        session[:session_token] = nil 

        if current_user 
          @current_user.resset_session_token! 
        end 

        @current_user = nil
    end
end
