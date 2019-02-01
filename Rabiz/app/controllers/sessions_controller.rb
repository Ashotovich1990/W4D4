class SessionsController < ApplicationController
   
    def new 
        :new
    end

    def create 
       user = User.find_by_credentials(user_params)

       if user 
        login(user)
        current_user
        redirect_to user_url(user)
       else  
        :new 
       end
    end

    def destroy 
      log_out!
      redirect_to new_session_url
    end

    private 
    
    def user_params 
     params.require(:user).permit(:email, :password) 
    end
end