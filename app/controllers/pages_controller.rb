class PagesController < ApplicationController
  #this is needed to clear the error if a user selects home from quote where flash message is active
  before_filter :clearErrors
  
  def index
=begin
    if @current_user
      redirect_to @current_user
    else  
      redirect_to '/pages/home'
    end
=end
    redirect_to '/pages/home'
  end
  
  #render home
  def home
    #redirect_to_current_user    
  end
  
  #render about
  def about
    #redirect_to_current_user
  end
  
  def contacts
    #redirect_to_current_user
    @new_contacts = ContactUs.new
    
    if request.post?
      logger.info "AppLog: Inside contacts" 
      
      if verify_recaptcha
        @new_contacts = ContactUs.create(params[:contactus])
        @new_contacts.request = request
        if @new_contacts.save
          call_rake :sendnow, :name => @new_contacts.name, 
                              :email => @new_contacts.email,
                              :adminemail => t('app.admin.email', default: 'darpanp@gmail.com') 
                              
          redirect_to pages_thankyou_path
        end
      else
        flash[:error] = "Something went wrong. Please try again!"
        render :action => 'contacts'
      end 
    end
  end
  
  def thankyou
    
  end

=begin
  
  #render projects
  def projects
    #redirect_to_current_user
  end
    
  def quote
    redirect_to_current_user
    if request.post?
      @quoteChoice = params[:quote]
      if @quoteChoice == 'new'
         redirect_to quotes_quote_first_path
      end
      
      if @quoteChoice == 'saved'
        @confirmation_number = params[:confirmation]
        logger.info "AppLog:" + "#{@confirmation_number}"
        
        if(@confirmation_number.length > 0)
          @order = Order.find_by_order_id(@confirmation_number)
          logger.info "AppLog:" + "#{@order}"
          
          if (! @order.nil?) && (@order.is_quote == true)
            session[:order] = @order
          
            @user = User.find_by_customer_id(@order.customer_id)
            session[:user] = @user
            redirect_to quotes_quote_second_path
          else
            flash[:errorQuote] = 'Confirmation number not valid.'
          end
        else
          flash[:errorQuote] = 'Make a selection or enter confirmation number.'
        end   
      end
      
      if @quoteChoice == nil
        flash[:errorQuote] = 'Please make a selection.'
      end
    end
  end
  
  def passwordreset
    if request.post?
      @email_for_pw_reset = params[:email]
      @current_user = User.resetPassword(@email_for_pw_reset)
      #logger.info "Applog: " + @current_user.customer_id
      unless @current_user.nil?
        EmailService.reset_password_email(@current_user).deliver
      end
      
      redirect_to sessions_destroy_path
    end
  end
   
  def redirect_to_current_user
    if @current_user
      redirect_to @current_user
    end
  end
=end  
  def clearErrors
    flash[:error] = nil
    #flash[:errorQuote] = nil
  end

end
