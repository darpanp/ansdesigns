module ApplicationHelper
=begin
  def company_logo
    return @company_root.elements["company/logo"].text
  end
  
  def company_name_font
    company_nm_font = @company_root.elements["company/name/@font"]
  end
  
  def company_name_no_font
    return @company_root.elements["company/name"].text
  end
  
  def company_name
    company_nm = @company_root.elements["company/name"].text
    
    if (! company_name_font.nil?)
      company_nm_string = "<font face=\"" + String(company_name_font) + "\">" + company_nm + "</font>"
    else
      company_nm_string = company_nm 
    end 
    
    #it is important to make this html_safe
    return company_nm_string.html_safe
  end
  
  def company_service
    company_srvc = @company_root.elements["company/service"].text
    
    if (! company_srvc.nil?)
      return company_srvc
    else
      return ""
    end
  end
  
  def company_email
    company_em = @company_root.elements["company/address/email"].text
    if company_em.nil?
      return "Not Available"
    else
      return company_em.html_safe  
    end
  end
  
  def company_mailing_address
    if(!@company_root.elements["company/address/mail/street"].text.nil?)
      mailing_street = @company_root.elements["company/address/mail/street"].text + "<br />"
    else
      mailing_street = ""
    end
    
    company_mail_address = @company_root.elements["company/address/mail/city"].text + ", " + @company_root.elements["company/address/mail/state"].text + " " + @company_root.elements["company/address/mail/zip"].text + "<br />"
    
    return (mailing_street + company_mail_address).html_safe   
  end
  
  def company_office_telephone
    company_phone = @company_root.elements["company/address/phone/office"].text
    if company_phone.nil?
      return "Not Available"
    else
      return company_phone.html_safe  
    end
  end
  
  def company_office_fax
    company_fax = @company_root.elements["company/address/phone/fax"].text
    if company_fax.nil?
      return "Not Available"
    else
      return company_fax.html_safe  
    end
  end
=end
end
