print "Enter a string : "
string = gets.chomp.to_s
string1 = ""
i=string.length()-1
while i>=0
    string1+=string[i]
    i-=1
end

puts string1
