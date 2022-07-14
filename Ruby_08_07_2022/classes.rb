class Box 
	$counts=0
	@@count=0
	def initialize(w,h)
		@width , @height = w,h
	end
	def show_data
     puts @width
     puts @height
	end
	def getWidth
		
	  @width
		
	end
	def getHeight
		
	  @height
		
	end

	# setter
	def setWidth=(value)
		@width = value
		
	end
	def setHeight=(value)
		@height = value
		
	end
	# instance method
	def getArea
		@width * @height

	end


end


class Box1
   @@class_va = 0
   @instance=0 
   def box1
      @instance=1

      puts "#{@instance} box1"
      puts "#{@@class_va}class_va box1"
   end
    def method_name
    	@instance=2
    	puts "#{@instance} method_name"
    end
    puts "#{@instance}instance in class"

end

box1=Box.new(332,56)
box1.show_data()
box1.setWidth=32
box1.setHeight=57
box1.show_data()
# instance method calling
puts box1.getArea()
box2=Box1.new()
box2.box1()
box2.method_name()