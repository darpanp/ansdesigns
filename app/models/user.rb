#require 'digest'
class User < ActiveRecord::Base
  has_many :orders, :dependent => :destroy #dependent will inform that all related orders should be deleted if the user is deleted
  #has_many :send_emails, :dependent => :destroy
  
  #filters
  before_create :generate_customer_id
  
  #UI validation while adding user
  # !!! Do not include :customer_id since this will never let get past registration - DP - Feb 25, 2012
  validates_presence_of :fullname, :email
  
  #conditional validation for password field since this model is used for quote flow where
  #password validation is not required on the first page.
  validates_presence_of :password, :if => :validatePasswordField? 
  
  #Regular expression to validate email address
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  #Validate format of email using the above RegEx
  validates_format_of :email, :with => EmailRegex
  
  #Validate uniqueness of email and customer id. This part is responsible for edit in UI that says that email is taken
  #or customer id is not unique.
  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :customer_id
  
  #Ensures that email and password match their confirmation fields
  validates_confirmation_of :password
  validates_confirmation_of :email
  
  #salt should only be accessible to this model
  attr_protected :salt
  
  #this is necessary to hash and validate password and confirmation against what is stored in the table.
  attr_accessor :password, :password_confirmation, :validate_password

  #use email and password for authentication
  def self.authenticate(emailaddress, submitted_password)
    user = find_by_email(emailaddress)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.admin_authenticate(emailaddress, submitted_password)
    user = authenticate(emailaddress, submitted_password)
    return nil if user.nil?
    return user if (user.has_password?(submitted_password) && user.is_admin?)
  end
  
  def is_admin?
    self.user_role == "ADMINISTRATORS"  
  end
  
  def validatePasswordField?
    validate_password
  end
  
  def has_password?(submitted_password)
    self.encrypted_password == encrypt(submitted_password)
  end
  
  def to_param
    "#{customer_id}"
  end
  
  #method to resetPassword for forgot password flow
  def self.resetPassword(emailaddress)
    user = find_by_email(emailaddress)
    unless user.nil?
      if (user.is_quote == false) #use false instead of '0' since we are in model
        user.password = rand(36**6).to_s(36).upcase #the password will be cleartext in a session - potential security issue!!!
        if user.save
          return user
        end
      end
    end
  end
  
  #This is an override that handles encryption of password before its saved. 
  #This approach was implemented after using a before_filter that encrypted the 
  #password but had other underlying issues.
  def password=(pass)
    unless pass.nil?
      @password = pass #!!! it is important to use instance variable here. Otherwise it will not work.
      self.salt = make_salt
      self.encrypted_password = encrypt(@password)
    end
  end
  
  def company=(comp)
    if comp.nil?
      @company_var = "N/A"
      self.company = @company_var
    end
  end
  
      
  
  protected
      def generate_customer_id
        @@rnd_cust_id = rand(36**12).to_s(36).upcase #This generates a 12 character alpha-numeric customer id
        @attributes['customer_id'] = @@rnd_cust_id
      end
      
  private
      #Following 3 methods are responsible for encrypting a given string.
      def encrypt(string)
        secure_hash("#{salt}#{string}")
      end
      
      def make_salt
        secure_hash("#{Time.now.utc}#{password}")
      end
      
      def secure_hash(string)
        Digest::SHA2.hexdigest(string)
      end
end
