class Book
 
 def initialize(count,price)
 	@count,@price = count,price
 	
 end

 def getPrice 
    @price * @count
 	
 end

end

class Book1 < Book
 def Print
	@area = @count * @price
	puts "Area of book #{@area}"
	
 end

end

# box = Book1.new(10,20)
box = Book.new(10,223)
puts box.getPrice()
# box.Print()