=begin
class UsersController < ApplicationController
  def show
    @user = User.find_by_customer_id(params[:id])
    @userfullname = @user.fullname
    session[:user] = @user
    
    session[:orders] = GetOrdersForCustomer(@user.customer_id)
    @orders = session[:orders]
    
    logger.info "AppLog: " + session[:orders].to_s
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])
    @user.validate_password = true
    @user[:is_quote] = false
    
    if @user.save
      EmailService.welcome_email(@user).deliver
      
      #auto login - set session then redirect
      session[:customer_id] = @user.customer_id
      redirect_to @user
    else
      render :action => 'new'
    end
  end
  
  def passwordreset
    if session[:user].nil? 
      redirect_to '/pages/home'
    end
    
    @user = session[:user]
    if request.post?
      @password = params[:user_password]
      @password_confirmation = params[:user_password_confirmation]
      
      if ((! @password.nil?) && password_match?(@password, @password_confirmation))
        @user.password = @password
        @user.is_quote = false
        
        if @user.save
            redirect_to @user
        else
            flash[:error] = 'Something went wrong saving the data!'
        end
      else
        flash[:error] = 'Password is blank or do not match'
      end  
    end
  end
  
  def GetOrdersForCustomer(custId)
    logger.info "AppLog: GetOrdersForCustomer has customer id of " + custId
    @orders = Order.find(:all, :conditions => "customer_id = '" + custId + "'")
    return @orders
  end

end
=end