# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Zeinerdsgn::Application.initialize!

#ActionMailer::Base.delivery_method = :smtp
#ActionMailer::Base.smtp_settings = {
#  :address => "mail.codingsherpa.com",
#  :port => 25,
#  :domain => "codingsherpa.com",
#  :user_name => "support+codingsherpa.com",
#  :password => "support123",
#  :authentication => :login,
#  :enable_starttls_auto => true,
#  :openssl_verify_mode => OpenSSL::SSL::VERIFY_NONE
#}
#ENV['RECAPTCHA_PUBLIC_KEY'] = '6LeH1dESAAAAALNtEWxDYnU0k-g1LCBxM493vbZn'
#ENV['RECAPTCHA_PRIVATE_KEY'] = '6LeH1dESAAAAAL8X6tMyH6nmjf2CdVo-EkA3ittl'
