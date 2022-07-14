$LOAD_PATH << '.'

require 'trig.rb'
require 'moral'

y = Trig.sin(Trig::PI/4)
puts y
wrongdoing = Moral.sin(Moral::VERY_BAD)
puts wrongdoing