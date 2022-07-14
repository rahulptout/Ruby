puts "Hash store implementation"
puts "Enter the key:"
ky = gets.chomp

puts "Enter the value:"
val = gets.chomp

h =Hash.new("#{ky}"=>val)
# puts hsh
# puts  "Key updated is #{hsh}"
# puts "Self hash object : #{hash1}"

puts "#{h[0]}"
