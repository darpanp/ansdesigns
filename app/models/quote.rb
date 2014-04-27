# April 2nd, 2012
# KEEP THIS CLASS SINCE THERE ARE USEFUL CODE THAT CAN BE RE_USED
# THERE ARE NO OTHER FILES THAT ARE OBSOLETE
# CAN STILL USE QUOTES-CONTROLLER AND QUOTES_HELPER FILES

class Quote < ActiveRecord::Base
  #Generate cust_id and quote_id before VALIDATION. When before_create was used, 
  #the :cust_id validation although displayed the UI edit, it still resulted in insertion of duplicate ID's
  #use of before_validation fixed the issue. :on => :create will ensure that the validation occurs only for create and not for update. 
  before_validation(:on => :create) do 
    generate_cust_id
    generate_quote_id
  end
  
  #For UI Edits - ensures that following fields are not blank
  validates_presence_of :cust_name, :cust_company, :cust_email
  
  #These are the piece of code that might be used later
  #validates_presence_of :cust_company, :if => :resume_step_is_1
  #validates_presence_of :cust_email, :if => :resume_step_is_1
  
  #Regular expression to validate email address
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  #Validate format of email using the above RegEx
  validates_format_of :cust_email, :with => EmailRegex 
  
  #ensures uniqueness of the field
  validates_uniqueness_of :cust_id
  #custom validation for unique id - compares with user table
  validate :is_cust_id_unique_compared_to_user
  
  #ensures uniqueness of email -> case insensitive
  validates_uniqueness_of :cust_email, :case_sensitive => false
  #custom validation for email - compares with user table
  validate :is_email_unique_compared_to_user
  
  protected
    def generate_cust_id
      @@rnd_cust_id = rand(36**12).to_s(36).upcase #This generates a 12 character alpha-numeric customer id
      @attributes['cust_id'] = @@rnd_cust_id 
    end
    
    def generate_quote_id
      @@rnd_quote_id = rand(36**16).to_s(36).upcase #This generates a 16 character alpha-numeric quote id
      @attributes['quote_id'] = @@rnd_quote_id
    end
    
    # CUSTOM_VAIDATION: Validate Customer Id against "USER" table
    # This is expected to work in cases where the random generator does not generate unique numbers.
    def is_cust_id_unique_compared_to_user
      user_with_cust_id = User.find_by_customer_id(cust_id)
      #logger.info "AppLog: #{cust_id}, #{user_with_cust_id}"
      if ! user_with_cust_id.nil?
        self.errors.add(:cust_id, " Id already taken. System Error. Try again later !")
      end  
    end
    
    # CUSTOM_VAIDATION: Validate Email against "USER" table
    # This is expected to fire more often since multiple users may have the same email id
    def is_email_unique_compared_to_user
      user_with_email = User.find_by_email(cust_email)
      #logger.info "AppLog: #{cust_email}, #{user_with_email}"
      if ! user_with_email.nil?
        #logger.info "AppLog: #{user_with_email.nil?}"
        self.errors.add(:cust_email, " already taken")
      end
    end
    
    #this is not used for now
    def resume_step_is_1
      if :resume_step == '1'
        return true 
      else
        return false
      end
    end
  
end
