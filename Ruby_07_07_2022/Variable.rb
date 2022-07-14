$global_variable = "this is a global variable";

class Class1 
	@@class_variable = "this is class variable"
     def printing_global

     @instance_variable = "this is a instance variable"	
     puts "#{$global_variable} access in method"
     puts "#{@instance_variable}  in a method"
     puts "#{@@class_variable}  in a method"
     end
     puts "#{@instance_variable}"
     puts "#{@@class_variable}  in a method"
end

class Class2
     VAR =100
     VAR1 = 200

     puts "#{VAR} class2"
	def printing_global2
		# puts "#{_local_variable}"
		 @instance_variable = 
        puts "#{VAR1} class2"
		puts "#{$global_variable} class2"
		puts "#{@instance_variable}this"
		_local_variable = "this is a local vairable"	
      puts "#{_local_variable}"
	end
	puts "#{@instance_variable}instance variable out of method"
end

class1 = Class1.new
class1.printing_global()
class2 = Class2.new
class2.printing_global2()