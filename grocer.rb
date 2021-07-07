require 'pry'
def consolidate_cart(cart)
  h = {} # creat a new hash
  cart.each do |e| # iterate each element in array
  # each element in the array has one key and multiple values as key/value pair
    h[e.keys[0]] = e[e.keys[0]] # added the first key in the first element of array to the hash
    # check the (hash) to increase value if exist   
    h[e.keys[0]].include?(:count) ? h[e.keys[0]][:count] += 1 : h[e.keys[0]][:count] = 1
  end
  # binding.pry
  # Return the hash
  h 
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon| 
    # ---> hash -> iterate key/value pair:  {:item=>"AVOCADO", :num=>2, :cost=>5.0}
    coupon.each do |i, att|
      # ---> iterate value of hash i is key -> :item --- while att is value -> "AVOCADO"
      
      # assign to variabls 
      name = coupon[:item]
      cart_price = cart[:price] , coupon_price = coupon[:cost], count_cart = cart[:count]
          num_coupon= coupon[:num]
          
      if cart[name] && cart[name][:count] >= coupon[:num]
        # compair item in cart and coupon if true. and compair quantity in cart and coupon if eq or more 
        
        if cart["#{name} W/COUPON"] # if already have a coupon for this item in the cart
          cart["#{name} W/COUPON"][:count] +=  num_coupon  #  increase :count by number of coupons. 
        else
          
          coupon[:cost] = coupon_price if cart[name][:count] > num_coupon
          
          cart["#{name} W/COUPON"] = {price: coupon_price / num_coupon, clearance: cart[name][:clearance], count: num_coupon} # set :count key equal to 1, since this is the first coupon for this item that we are adding to our cart.
        end
        cart[name][:count] -= coupon[:num]
      end
      # binding.pry
    end
  end
  cart
  
end

def apply_clearance(cart)
   
  cart.each do |i, att| 
    
    price = att[:price]
    discount = price * 20 / 100
    att[:clearance] ? att[:price] = (price - discount).round(2) : att[:price] = price
  end
  cart
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart) # assign consolidate_cart to new_cart
  coupons_cart = apply_coupons(new_cart, coupons) # assign apply_coupons(new_cart, coupons) to coupons_cart // coupons_cart = new_cart and coupons
  clearance_cart = apply_clearance(coupons_cart)
  
  total = 0 
  clearance_cart.each do |i, att|
    # binding.pry
    total += (att[:price] * att[:count])
    # binding.pry
  end
  total = (total * 0.9) if total > 100
  total   
   
end

# def apply_coupons(cart, coupons)
#   h2 = {}
  
#     cart.each do |i|
#       item_cart = i[0]
#       price_key= i[1].keys[0]
#       price = i[1].values[0]
      
#       clearance_key= i[1].keys[1]
#       clearance = i[1].values[1]
      
#       count_key= i[1].keys[2]
#       count = i[1].values[2]
      
      
#       quantity = count
#       h2[item_cart] = i[1]
      
#       coupons.each do |e|
#         # p e.keys[0]
        
#         item_coupons =  e.values[0]
#         num_key = e.keys[1]
#         num = e.values[1]
        
#         cost_key = e.keys[2]
#         cost = e.values[2]
#         if count == num  
#           total = cost / num
#           quantity =  count - num
          
          
#         end
#         if count > num 
#           # total = (count - num) * price + cost / num
#           total = cost / num
#           quantity = count - num
        
#       end
      
      
      
       
#       h2["#{item_coupons} W/COUPON"]={price: total, clearance: clearance, count: num }
      
      
#     end
#   h2[item_cart][count_key] = quantity
    
#   end
#   h2
  
#end
