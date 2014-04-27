=begin
require 'rexml/document'
class QuotesController < ApplicationController
  def quote_first
    @user = User.new
    @order = Order.new
    
    if request.post?
      @user = User.create(params[:user])
      @user.validate_password = false
      @user[:is_quote] = true
      
      if @user.save
        session[:user] = @user
        session[:order] = @order
        redirect_to quotes_quote_second_path
      else
        render :action => 'quote_first'
      end
    end
  end
  
  def quote_second
    if request.post?
      if ! params[:work_type].nil?
        @params_order_type = params[:work_type].each { |x| puts x }
        @params_order_qty = params[:work_qty].each { |x| puts x }
        session[:ordertype] = @params_order_type
        session[:orderqty] = @params_order_qty
        
        redirect_to quotes_quote_third_path
      else
        flash[:error] = 'No selection made'
      end
    end
      
    @path_to_price_quote = Rails.root + "config/extras/PriceQuote.xml"
    @xml = File.read(@path_to_price_quote)
    @xmldoc = REXML::Document.new(@xml)
    @root = @xmldoc.root
    @drawing = @xmldoc.elements.to_a("//drawing")
    
    #Save to session
    session[:pricequote] = String(@root)
  end
  
  def quote_third
    if request.post?
      @quote_choices = params['quote_choices']
      @order = session[:order]
      
      if ! @quote_choices.nil?
        session[:quotechoices] = @quote_choices
        case @quote_choices
          when 'register' 
            #@quote[:resume_step] = 2
            @order[:order_subtotal] = session[:subtotal]
            @order[:order_status] = "QUOTE_COMPLETE"
            #@quote[:reminder_date] = 'NULL'
            #SEND WELCOME EMAIL
          when 'save_quote'
            #@quote[:resume_step] = 2
            @order[:order_subtotal] = session[:subtotal]
            @order[:order_status] = "QUOTE_SAVED"
            #@quote[:reminder_date] = 'NULL'
            #SEND EMAIL
          when 'reminder'
            #@quote[:resume_step] = 2
            @order[:order_subtotal] = session[:subtotal]
            @order[:order_status] = "QUOTE_REMIND"
            
            @sendemail = SendEmail.new
            @sendemail[:customer_id] = session[:user].customer_id #not sure if user object is valid here
            @sendemail[:order_id] = @order.order_id
            @sendemail[:is_quote] = true
            @sendemail[:reminder_date] = Date.today + 2 #Date.today >> 1 #to advance by a month
            
            if ! @sendemail.save
              return    #this is to exit out of this method so it will stay on the same page    
            end
        end
        
        if @order.save
          session[:order] = @order
          if @quote_choices == 'save_quote'            
            EmailService.saved_quote_email(session[:user], @order).deliver
          end
          redirect_to quotes_quote_fourth_path
        end
      else
        flash[:error] = 'No selection made'
      end
    end
    
    @user = session[:user]
    @order = session[:order]
    @order[:customer_id] = @user.customer_id
    
    @choices = Array.new
    @params_order_type = session[:ordertype]
    @params_order_type.collect {|k,v| @choices << k}
    
    @quantity = session[:orderqty]
      
    @order[:order_type] =  @quantity.collect {|k,v| "#{k}"}.join(',')
    @order[:order_qty_or_hour] = @quantity.collect {|k,v| "#{v}"}.join(',')
    #logger.info "AppLog: " + @params_order_type.collect {|k,v| "#{k}"}.join(',') + " " + @quantity.collect {|k,v| "#{v}"}.join(',')
    
    @order[:is_quote] = true
    if @order.save
      session[:order] = @order #update order object
    end
  end
  
  def quote_fourth
    @quote_choices = session[:quotechoices]
    @user = session[:user]
    
    if request.post? && (@quote_choices == 'register')
      @password = params[:user_password]
      @password_confirmation = params[:user_password_confirmation]
      
      if ((! @password.nil?) && password_match?(@password, @password_confirmation))
        @user.password = @password
        @user.is_quote = false
        #@user.validate_password = true
      
        if @user.save
          @order = session[:order]
          @order.is_quote = false
          
          if @order.save
            #cleanup everything from session and start fresh!
            reset_session
            
            #TEMPORARY DISABLED FOR DEVELOPMENT - SHOULD ENABLE THIS FOR PRODUCTION
            EmailService.welcome_email(@user).deliver
            
            #auto login - set session then redirect
            session[:customer_id] = @user.customer_id
            redirect_to @user
          else
            flash[:error] = 'Something went wrong saving the data!'
            raise ActiveRecord::Rollback  
          end
        else
          flash[:error] = 'No password provided'
        end
        #logger.info "AppLog: " + @username + " " + @password
        #CopyDataToUserTable(@quote, @username, @password)
      else
        flash[:error] = 'Please provide and confirm password'
      end
    end
  end
end
=end
  
=begin
  def password_match?(password, confirmpass)
    if password.length > 0 && confirmpass.length > 0
      password == confirmpass
    else
      false
    end
  end
=end

