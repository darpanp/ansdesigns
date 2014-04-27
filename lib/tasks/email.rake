
namespace :email do
  desc "send emails to contacts"
  task :send => :environment do
    @emailsToSend = SendEmail.find(:all, :conditions => ('reminder_date = \'' + Date.today.to_s() + '\''))
    @emailsToSend.each do |email|
      #Extra check to ensure that quote field is enabled
      if(email.is_quote == '1') 
        @user = User.find_by_customer_id(email.customer_id)
        EmailService.reminder_email(@user, email).deliver
      end
    end
  end
  
  desc "send emails to customer and administrator"
  task :sendnow => :environment do
    #debugger
    @name = ENV["NAME"]
    @email = ENV["EMAIL"]
    @admin_email = ENV["ADMINEMAIL"]
    
    @contactusCollection = ContactUs.find(:all, :conditions => ('name = \'' + @name + '\' and email = \'' + @email + '\''))
    
    @contactusCollection.each do |contactUs|
      EmailService.contact_us_admin_notify_email(contactUs, @admin_email).deliver  
      EmailService.contact_us_receipt_email(contactUs).deliver
    end
    
  end
  
  desc "send email to admin based on response from the server"
  task :check_web_status => :environment do
    @email = ENV["EMAIL"]
    @text = ENV["TEXT"]
    @url = ENV["URL"]
    EmailService.status_email(@email, @text).deliver
  end
end


