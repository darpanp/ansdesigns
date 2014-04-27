class Order < ActiveRecord::Base
  belongs_to :user
  
  before_validation(:on => :create) do 
    generate_order_id
  end
  
  #before_create :compute_total
  
  protected
    def generate_order_id
      @@rnd_order_id = rand(36**16).to_s(36).upcase #This generates a 16 character alpha-numeric order id
      @attributes['order_id'] = @@rnd_order_id
    end
    
    #def compute_total 
    #end
    
    
end
