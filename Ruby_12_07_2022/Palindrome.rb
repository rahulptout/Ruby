print 'Enter a number : '
number = gets.chomp.to_i
puts number 
# number = 121
temp = number
rem = 0
divi = 10
while temp>0 
	valu = temp % divi
	# puts valu
	rem+=valu
	 temp = temp-valu
	 divi*=10
	# puts temp

	# valu = temp % divi
	# puts valu
	# rem+=valu
	#  temp = temp-valu
	#  divi*=10
	# puts temp

	# valu = temp % divi
	# puts valu
	# rem+=valu
	#  temp = temp-valu
	#  divi*=10
	# puts temp

	# puts rem
	# puts temp

  
	
end
puts rem

if number==rem
	puts "this number #{number} is palindrome"
	
else
   puts "this number#{number} is not palindrome"	
end