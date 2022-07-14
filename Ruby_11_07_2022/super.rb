class Animal

  def initialize(w,h)
@width, @height = w,h

end
  def name
    puts "Animal"
  end
end

class Cat < Animal
  def name
    super
  end
end

cat = Cat.new(12,34)
cat.name

