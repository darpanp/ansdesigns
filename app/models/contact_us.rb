class ContactUs < ActiveRecord::Base
  validates_presence_of :name, :email, :subject, :message
  
  #Regular expression to validate email address
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  #Validate format of email using the above RegEx
  validates_format_of :email, :with => EmailRegex
  
  def request=(request)
    self.user_ip = request.remote_ip
    self.user_agent = request.env['HTTP_USER_AGENT']
    self.referrer = request.env['HTTP_REFERER']
  end
  
end
