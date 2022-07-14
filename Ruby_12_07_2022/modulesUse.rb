$LOAD_PATH << '.'
require "modules"  # fileName
# moduleName.methodName
# MODULES.palindrome

class Demo1 
	 puts "this is demo1 class"
	include Modules
  

end

class Demo2
	puts "this is demo2 class"
	extend Modules

end	



demo1 = Demo1.new()
demo1.palindrome
# Modules.palindrome()


Demo2.palindrome



