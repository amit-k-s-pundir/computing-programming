# def nTimes(aThing)
#   return proc { |n| aThing * n }
# end
# p1 = nTimes(23)
# puts p1.call(3) 
# puts p1.call(4) 
# puts p2 = nTimes("Hello ")
# puts p2.call(3)

class Person < ActiveRecord::Base
end

p = Person.new(:name => "Sonu")
