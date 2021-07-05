array = [
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"KALE"    => {:price => 3.00, :clearance => false}}
]

def consolidate_cart2(cart)
  y = cart.each {|x| x}
  y.each {|z| z[:count] ? z[:count] += 1 : z[:count] = 1 }
end

def consolidate_cart(cart)
 cons_cart = {}
  cart.each do |item|
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

def testing(cart)
  new_cart = {}
  cart.each do |item|
    new_cart[:item]
  end
end

p testing(array)

p consolidate_cart2(array)
# p consolidate_cart(array)