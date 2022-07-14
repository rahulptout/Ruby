class Laptop
  
def initialize(w,h)
@width, @height = w,h

end

def getScreenSize()


puts "#{@width * @height}"
end

end



class Laptop1 < Laptop 



def getScreenSize
# super
 @area = @width * @height 
puts "laptop1 #{@area}"

end
end


laptop = Laptop1.new(10,34)
laptop.getScreenSize()