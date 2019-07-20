def consolidate_cart(cart)
  consolidated_cart = {}
  cart.map { |item| 
    if !consolidated_cart[item.keys[0]]
      consolidated_cart[item.keys[0]] = item.values[0]
      consolidated_cart[item.keys[0]][:count] = 1
    else
      consolidated_cart[item.keys[0]][:count] += 1
    end
  }
  consolidated_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.has_key?(coupon[:item])
      if !cart[coupon[:item] + " W/COUPON"]
        cart[coupon[:item] + " W/COUPON"] = {
          price: coupon[:cost]/coupon[:num],
          clearance: cart[coupon[:item]][:clearance],
          count: cart[coupon[:item]][:count] - (cart[coupon[:item]][:count]%coupon[:num])
        }
        cart[coupon[:item]][:count]-= cart[coupon[:item] + " W/COUPON"][:count]
      else
        if cart[coupon[:item]][:count] >= coupon[:num]
          cart[coupon[:item] + " W/COUPON"][:count] += coupon[:num]
          cart[coupon[:item]][:count] -= coupon[:num]
        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each { |key, value|
    value[:price] = (value[:price]*0.8).round(2) if value[:clearance]
  }
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupons_applied_cart = apply_coupons(consolidated_cart, coupons)
  clearance_applied_cart = apply_clearance(coupons_applied_cart)
  checkout_total = clearance_applied_cart.reduce(0) { |memo, (key, value)|
    memo+=value[:price]*value[:count]
    memo
  }
  checkout_total = (checkout_total*0.9).round(2) if checkout_total > 100
  checkout_total
end
