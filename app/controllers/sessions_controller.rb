=begin
class SessionsController < ApplicationController
  def new
  end

  def create
    #find user based on username and password
    @current_user = User.authenticate(params[:username], params[:password])
    
    if @current_user
      session[:customer_id] = @current_user.customer_id
      if session[:return_to]
        redirect_to session[:return_to]
        session[:return_to] = nil
      else
        #redirect to the users stats page. @current_user will provide /user/:id
        redirect_to @current_user
      end
    else
      flash[:error] = 'Login Unsuccessful.'
      #display the login page if the user is not found
      render 'pages/home' #SUGGESTION: can we stick to current URL?
    end
    
  end

  def destroy
    #set nil values to session and instance variable when user logs out.
    session[:customer_id] = @current_user = nil
    session[:user] = nil
    session[:orders] = nil
    session[:adminuser] = nil
  end
end
=end
