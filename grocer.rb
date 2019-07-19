
def consolidate_cart(items)
  new_hash = {}
  counter = 0

    items.each do |hash_name|
      hash_name.each do|key, value|
      new_hash[key] = value


      #new_hash[key][:count] = counter
      if new_hash[key][:count]
        new_hash[key][:count] += 1
      else
        new_hash[key][:count] = counter
        new_hash[key][:count] += 1
      end
    end
    end



  p new_hash

end



  def apply_coupons(cart, coupons)

      new_cart = cart
      coupons.each do |coupon|
          name = coupon[:item]
          coup_num = coupon[:num]

        #this below to deal with more items then coupons
          if cart.include?(name) && cart[name][:count] >= coup_num
             new_cart[name][:count] -= coup_num


        # check if additional W/coupon already there if so adjust numbers
       if new_cart["#{name} W/COUPON"]
            new_cart["#{name} W/COUPON"][:count] += coup_num

        # create new additoan W/coupon line
             else
                  new_cart["#{name} W/COUPON"] =  {
                      :price => (coupon[:cost] / coup_num),
                      :clearance => new_cart[name][:clearance],
                      :count => coup_num
                  }
              end # if 2
end
      end # each
    p new_cart
  end



def apply_clearance(cart)


#  items.each do |hash_name|
#    hash_name.each do|key, value|
#    new_hash[key] = value

clear_cart = cart

clear_cart.each do|item, hash|

if hash[:clearance] == true
cal_price = hash[:price]
percent = ((cal_price / 100)*20)
new_price = (cal_price -= percent)

hash[:price]  = new_price

end
end

end

def checkout(cart, coupons)
  # code here

part_a_cart = consolidate_cart(cart)
part_b_cart = apply_coupons(part_a_cart, coupons)
final_cart = apply_clearance(part_b_cart)

total_price = 0.00

final_cart.each do|item, hash|

total_price += hash[:price] * hash[:count]


end

if total_price > 100.00

 total_price = (total_price - ((total_price / 100)*10))



end

return total_price


end
