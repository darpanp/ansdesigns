module QuotesHelper
  
  def compute_total_price
    @total = 0  
    
    #read pricequote xml from session
    @xmldoc = REXML::Document.new(session[:pricequote])
    @root = @xmldoc.root
    
    @choices.each do |choice|
      if choice.include? '1'
        @total += (Integer(@root.elements["drawing[@size=\'" + choice[0, 1] + "\']/density/low"].text) * Integer(@quantity[choice]));
      end
      if choice.include? '2'
        @total += (Integer(@root.elements["drawing[@size=\'" + choice[0, 1] + "\']/density/medium"].text) * Integer(@quantity[choice]));
      end
      if choice.include? '3'
        @total += (Integer(@root.elements["drawing[@size=\'" + choice[0, 1] + "\']/density/high"].text) * Integer(@quantity[choice]));
      end
    end
    
    session[:total] = @total
    
    return String(@total) + ".00"
  end
  
  def compute_service_tax
    @service_tax = 0
    
    session[:servicetax] = @service_tax
    return "00.00" if @service_tax == 0
    return "XX.XX"
  end
  
  def compute_subtotal
    @subtotal = @total + @service_tax
    
    session[:subtotal] = @subtotal
    
    return String(@subtotal) + ".00"
  end
  
  def display_confirmation_text
    @order = session[:order]
    confirmation_text = case @quote_choices
    when 'save_quote'
      "We have saved your quote and also sent the following quote confirmation number to the email address that you provided. <br /><br />Confirmation #: <b>" + @order[:order_id] + "</b><br /><br />
       Please use this confirmation number to retrieve and try a new quote. <br /><br />Thank you for visiting our site."
    when 'reminder'
      "Sorry to see you go away. We'll send you a reminder in about a month to see if you are interested.
       No more emails after that - we promise!"
    end
    confirmation_text  
  end
  

end
