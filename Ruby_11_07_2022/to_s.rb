class Car

def initialize(p,y)
@price ,@year = p , y

end

def to_s
	
	"w : #{@price}, #{@year}"
	
end

end


car1 = Car.new(10,20)

puts ("#{car1}")