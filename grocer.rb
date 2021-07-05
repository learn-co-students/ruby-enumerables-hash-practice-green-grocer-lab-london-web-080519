require 'pry'

def consolidate_cart(cart)
 cons_cart = {}
  cart.each do |item|
 #  binding.pry 
    if cons_cart[item.keys[0]]
      cons_cart[item.keys[0]][:count] += 1
    else
      cons_cart[item.keys[0]] = {
        price: item.values[0][:price],
        clearance: item.values[0][:clearance],
        count: 1
      }
    end
  end
  cons_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon| 
    if cart.key?(coupon[:item]) && cart[coupon[:item]][:count] >= coupon[:num] # if item exists AND item's count is greater than the coupon's number
      discounted_item = "#{coupon[:item].upcase} W/COUPON" 
        if cart[discounted_item] 
          cart[discounted_item][:count] += coupon[:num] 
          # ^^ increments coupon count if two are applied 
        else cart[discounted_item] = { 
          price: coupon[:cost] / coupon[:num], 
          clearance: cart[coupon[:item]][:clearance], 
          count: coupon[:num] 
          } 
        end 
    cart[coupon[:item]][:count] -= coupon[:num] 
    end 
  end 
  cart 
end


def apply_clearance(cart)
  cart.each do |z| 
    if z[1][:clearance]
    #apply clearance
       clearance_price = z[1][:price] * 0.8
       z[1][:price] = clearance_price.round(2)
    else
    # do we need an else?
    end
  end
  cart
end

def checkout(cart, coupons)
  # consolidates the cart
  consolidated_cart = consolidate_cart(cart)
  # applies the coupons
  couponed_cart = apply_coupons(consolidated_cart, coupons)
   # applies the discounts
  discounted_cart = apply_clearance(couponed_cart)
  # adds up the cost of entire cart
  subtotal = 0
  discounted_cart.each do |key|
    subtotal += key[1][:price] * key[1][:count]
    end
  # returns the subtotal
  # if subtotal is over $100, apply additional 10% off, else subtotal
  if subtotal > 100 
    total_due = subtotal * 0.9
  else
    total_due = subtotal
  end
  total_due.round(2)
end

cart =  [
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"KALE"    => {:price => 3.00, :clearance => false}},
  {"CHEESE"  => {:price => 3.00, :clearance => false}}
]
coupons = [
  {:item => "AVOCADO", :num => 2, :cost => 5.00},
  {:item => "AVOCADO", :num => 2, :cost => 5.00},
  {:item => "BEER", :num => 2, :cost => 20.00},
  {:item => "CHEESE", :num => 3, :cost => 15.00}
]


 
