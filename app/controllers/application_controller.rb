require 'rexml/document'
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def call_rake(task, options = {})
    options[:rails_env] = Rails.env
    args = options.map { |n,v| "#{n.to_s.upcase}='#{v}'"}
    taskname = "email:#{task}"
    #logger.info "AppLog: bundle exec rake #{taskname} #{args.join(' ')} --trace"
    system "bundle exec rake #{taskname} #{args.join(' ')} --trace &"
  end
=begin
  
  #to call :fetch_logged_in_user before any other controller action is called. 
  #Check if the user is logged in.
  before_filter :fetch_logged_in_user, :read_company_info
  
  def password_match?(password, confirmpass)
    if password.length > 0 && confirmpass.length > 0
      password == confirmpass
    else
      false
    end
  end
  
  ###??? Still not sure how logged_in? and login_required is called
  protected
    def read_company_info
      path_to_companyinfo = Rails.root + "config/extras/Company.xml"
      xml = File.read(path_to_companyinfo)
      xmldoc = REXML::Document.new(xml)
      @company_root = xmldoc.root    
    end
    
    def fetch_logged_in_user
      return unless session[:customer_id]
      logger.info "AppLog: fetch_logged_in_user called" 
      @current_user = User.find_by_customer_id(session[:customer_id])
      if @current_user.nil?
        session[:customer_id] = nil 
        redirect_to root_path
      else 
        @userfullname = @current_user.fullname
      end
    end
    
    def logged_in?
      ! @current_user.nil?
    end
    
    helper_method :logged_in?
    
    def login_required
      return true if logged_in?
      session[:return_to] = request.url
      redirect_to root_path and return false
    end
=end

end
