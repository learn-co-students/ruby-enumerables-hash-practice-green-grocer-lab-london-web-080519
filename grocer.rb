def consolidate_cart(cart)
  # code here
  cart_consolidated = {}

  cart.each do |element|
    if cart_consolidated.include?(element[0])
      cart_consolidated[element[0]][:count] += 1
    else
      cart_consolidated = {
        element[0] = {
          price: element[1][:price],
          clearance: element[1][:clearance],
          count: 1
        }
      }
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here

end
