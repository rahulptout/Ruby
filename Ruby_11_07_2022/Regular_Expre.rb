line1 = "Cats are smarter than dogs";
line2 = "Dogs also like meat Cats";
line3 =" ruby ruby Ruby"
# if ( line1 =~ /Cats(.*)/ )
#    puts "Line1 contains Cats"
# end
# if ( line2 =~ /Cats(.*)/ )
#    puts "Line2 contains  Dogs"
# end

# if (line3 =~ /[Rr]uby/)
#    puts "ruby is matches"
   
# end

# Matches any one lowercase vowel.
# if line3=~/[aeiou]/
#    puts "it's content vowel"
   
# end

# if line3=~/\d/ #if digits matches
#    puts "digits matches"
# end

# if line3=~/[^A-Za-z0-9]/
#    puts "non matches"
# end

# if line3 =~/ruby+/
#    puts "#{line3 =~/ruby*/}"
# end

# if line3 =~/\d{3}/
#    puts "#{line3 =~/\d{3}/}"
# end


phone = "2004-959-559 #This is Phone Number"
phone1 = "helllo #hwllllll rgw"
puts phone
# Delete Ruby-style comments
phone = phone.sub!(/#.*$/, "")  
phone1 = phone1.sub(/#.*$/," ") 
puts "Phone Num : #{phone}"
puts "phone num : #{phone1}"

# # Remove anything other than digits
# phone = phone.gsub!(/\D/, "")    
# puts "Phone Num : #{phone}"


   

# puts "Ruby".gsub!(/[tyru]/, '<\1>')          
# puts "String".gsub!(/([ab])/, '*')  
