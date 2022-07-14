def  pattern1(number)
 i=1
 j=1
   while i<=number
   	 while j<=i		
   		print "*"
   		j+=1   		
   	 end
   	  puts ""
   	  i+=1
   	  j=1
   end	
end

# pattern1(10)


def sample (*test)
   puts "The number of parameters is #{test.length}"
   for i in 0...test.length
      puts "The parameters are #{test[i]}"
   end
end
sample "Zara", "6", "F"
# sample "Mac", "36", "M", "MCA"