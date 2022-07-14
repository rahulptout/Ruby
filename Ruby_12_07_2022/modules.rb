module Modules

   def palindrome
      
    #     print "Enter a number : "
    # number = gets.chomp.to_i
    number = 121
    puts number 

    temp = number
    rem = 0
    divi = 10
    while temp>0 
   valu = temp % divi
   rem+=valu
    temp = temp-valu
    divi*=10

    end
   puts rem

 if number==rem
   puts "this number #{number} is palindrome"
   
 else
   puts "this number#{number} is not palindrome"   
 end

   end
  

  #module end 
end
