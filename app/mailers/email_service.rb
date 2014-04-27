class EmailService < ActionMailer::Base
  default :from => "support@codingsherpa.com",
          :return_path => "support@codingsherpa.com"
  
  def welcome_email(recipient)
    @fullname = recipient.fullname
    @email = recipient.email
    @password = recipient.password
    @company_name = "A&S Designs"
    @support_email = "support@codingsherpa.com"
    @url = "http://zdesign.codingsherpa.com"
    
    mail(:to => recipient.email,
         :subject => "Welcome to " + @company_name + "!")
  end
  
  def reset_password_email(recipient)
    @fullname = recipient.fullname
    @email = recipient.email
    @password = recipient.password
    @company_name = "A&S Designs"
    @support_email = "support@codingsherpa.com"
    @url = "http://zdesign.codingsherpa.com"
    
    mail(:to => recipient.email,
         :subject => "New password requested at " + @company_name + "!")
  end
  
  #This may not be needed since it was used to test reminder email earlier!!!
  def test_scheduled_email(recipient)
    @fullname = recipient.fullname
    @email = recipient.email
    @password = recipient.password
    @company_name = "A&S Designs"
    @support_email = "support@codingsherpa.com"
    @url = "http://zdesign.codingsherpa.com"
    
    logger.info "AppLog: test_Scheudled_email " + recipient.fullname
    
    mail(:to => recipient.email,
         :subject => "Scheduled email from " + @company_name + "!")
  end
  
  def reminder_email(recipient, reminder_content)
    @fullname = recipient.fullname
    @order_id = reminder_content.order_id
    
    @company_name = "A&S Designs"
    @support_email = "support@codingsherpa.com"
    @url = "http://zdesign.codingsherpa.com"
    
    mail(:to => recipient.email,
         :subject => "Reminder email from " + @company_name + "!")
  end
  
  def saved_quote_email(recipient, order)
    @fullname = recipient.fullname
    @email = recipient.email
    @order_id = order.order_id
    @company_name = "A&S Designs"
    @support_email = "support@codingsherpa.com"
    @url = "http://zdesign.codingsherpa.com"
    
    mail(:to => recipient.email,
         :subject => "You have saved quote at " + @company_name)
  end
  
  def contact_us_receipt_email(contactUs)
    @fullname = contactUs.name
    @email = contactUs.email
    @submitted_subject = contactUs.subject
    @company_name = "A&S Designs"
    @support_email = t('app.support.email', default: 'support@codingsherpa.com')
    @url = "http://ansdesign.codingsherpa.com"
    
    mail(:to => @email,
         :subject => "Thank you for contacting " + @company_name)
  end
  
  def contact_us_admin_notify_email(contactUs, admin_email)
    @fullname = contactUs.name
    @email = contactUs.email
    @submitted_subject = contactUs.subject
    @submitted_message = contactUs.message
    
    mail(:to => admin_email,
         :subject => "New message submitted by " + @fullname)
  end
  
  def status_email(email, text)
    mail(:to => email, :subject => text)
  end
  
end
