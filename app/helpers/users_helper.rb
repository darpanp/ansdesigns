module UsersHelper
  #def generate_customer_id
  #  @@rnd_cust_id = rand(36**12).to_s(36).upcase #This generates a 12 character alpha-numeric customer id
  #  @attributes['customer_id'] = @@rnd_cust_id
  #end
  
  #def GetOrdersForCustomer(custId)
  #  @orders = Order.find_by_customer_id(:all, :condition => "customer_id = '" + custId + "'")
  #  return @orders
  #end
end
