=begin
class SupportController < ApplicationController
  before_filter :fetch_admin_credentials
  respond_to :html, :js
  
  def adminlogin
    if request.post?
      @current_user = User.admin_authenticate(params[:username], params[:password])
      if @current_user.nil?
        flash[:error] = 'Invalid Login'
      else
        session[:adminuser] = @current_user
        session[:customer_id] = @current_user.customer_id
        redirect_to support_ansadmin_path
      end
    end
  end
  
  def ansadmin
  end
  
  def manageusers
    @user = User.new
    
    #if request.post?
    #  respond_to do |format|
    #    format.html {render :action => 'manageusers'}
    #    format.js
    #  end
    #end
  end
  
  def fetch_admin_credentials
    @curr_action = self.action_name
    if(@curr_action != 'adminlogin' && session[:adminuser].nil?)
      redirect_to '/support/adminlogin'
    end
  end
  
  def findallmatchingusers
    @fullname = params[:fullname]
    logger.info "Applog: in find all matching users method + " + @fullname

    @users = User.find(:all, :conditions => ["fullname like ?", @fullname + "%"], :limit => 5)
    logger.info "Applog: " + @users.to_s                    
    respond_with @users
  end
end
=end