class Demo1
  def initialize(string)
    @string = string 

  end


def Reverse() 
  
 @string1 = " "
@i=@string.length()-1
while @i>=0
    @string1+=@string[@i]
    @i-=1
end

puts "#{@string1}"
	
end
end
print "Enter a String : "
input = gets.chomp.to_s
demo1 = Demo1.new(input)
demo1.Reverse()