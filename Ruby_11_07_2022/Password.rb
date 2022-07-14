def  PasswordValidation(password)

 if password=~/[a-z]/
 	puts "password lowercase done"
 end
 if password=~/[A-Z]/
 	puts "password uppercase done"
 end
 if password=~/[0-9]/
 	puts "password numeric done"
 end

 if password.length>=8
     puts "length is grater than 8 done"
 	
 end
  if password=~/[!@#$]/
  	   puts "password special charactor done"
  

 else
    puts "Please use lower,upper,numeric,special case charactor"  
  end
end

print "Enter your password :"
password = gets.chomp.to_s
PasswordValidation(password)