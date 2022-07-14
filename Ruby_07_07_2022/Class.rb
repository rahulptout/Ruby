class Car 
	@@no_of_car = 0; #class variables
	# puts @no_of_car;

	def initialize(id,name,address)
		@@no_of_car+=1
		@car_id = id
		@car_name = name
		@car_address = address

	end	

	def printing()
		puts"Number of car entry : #{@@no_of_car}"
		puts"car id : #{@car_id}"
		puts"car name : #{@car_name}"
		puts"car location : #{@car_address}"


		
	 end
end

# object create and initialize
car1 = Car.new("1","volvo","indore")
car2 = Car.new("2","maruti","sanawad")
# method calling
car1.printing()
