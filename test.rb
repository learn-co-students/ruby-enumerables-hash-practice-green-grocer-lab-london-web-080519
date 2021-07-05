def consolidate_cart(cart)
end

array = [
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"KALE"    => {:price => 3.00, :clearance => false}}
]

def pseudo_code(array) 
  # 1. for each element of the array, count how many times it appears
  # 2. return all unique values of the array
  # 3. include in the hash a new key:value pair of :count, the number of times that element of the array appears
  p array.each {|x| count(array[x]) }
end

def try1(array)   # returns the number of unique values within the array
  p array.uniq.count 
end  

#try1(array) #=> 2 
# p array.uniq

def try2(array)
  array << {count: 1}
  p array
end

# try2(array) ##=> adds (count: 1) to the end, not to each element

# p array << {count: 1}  # this array 
array[0][:count] = 1
p array[0]
  #= > {"AVOCADO"=>{:price=>3.0, :clearance=>true}, :count=>1} 

p array.count("AVOCADO") #=> 0 WHHYYY