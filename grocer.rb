def consolidate_cart(cart)
  consolidated = {} #create new hash to store consolidated hashes
  cart.each do |item| #iterates over each iten in array
    item.each do |k, v| #iterates over each hash's key and value
      if consolidated.key?(k) == false #check if this key is already in new consolidated hash
        consolidated[k] = v #add to new hash
        consolidated[k][:count] = 1 #add value of counter and set to 1
      else #if key is already present in hash
    counter = consolidated[k][:count] + 1
        consolidated[k][:count] += 1
      end
    end
  end
  consolidated
end

#coupons is the name of the array that contains the coupons
  #check if item is included in cart array
  #divide cost by num to get the discounted price of the couponed item
  #check how many items there are, if number of items is equal or less than the "num" of coupon, then use original number of items
  #if it is greater, then create new key with non discounted item numer "num" - items
  #return new hash with discounted prices

  #"${item} W/ COUPON"
  # code here

  #check if item is included in cart array
  #if discounted item is in the cart, check by seeing if item_name matches the key of one of the hashes in cart

  def apply_coupons(cart, coupons)
    coupons.each do |coupon|

    if cart.key?(coupon[:item]) && cart[coupon[:item]][:count] >= coupon[:num]
        disc_item = "#{coupon[:item]} W/COUPON"
        if cart[disc_item]
          cart[disc_item][:count] += coupon[:num]
      #accounts for if there are more than one coupons, increment coupon count if two are applied
        else cart[disc_item] = {
          price: coupon[:cost]/coupon[:num],
          clearance: cart[coupon[:item]][:clearance],
          count: coupon[:num] }
        end
          cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
    cart
 end

def apply_clearance(cart)
  cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price]*0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  all_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))

  total = 0
  all_cart.each do |item|
      qty = item[1][:count]
      price = item[1][:price]
      total += qty * price
    end
  if total > 100
    total = (total * 0.9).round(2)
  end
  total 
end
