$dataNumber = 0

class Student_Percentage

  def initialize(count, subjects)

  @count = count
  @subjects = subjects

  end

  def calculation
    @sum = 0
    @per = 0
    @subjects.each do |i|
      @sum += i
    end
    @per = (@sum / @count)
    puts "student percentage : #{@per}%"
  end
end




class DataInsert
  def input

    $dataNumber +=1
    puts "Student :---------- #{$dataNumber}"
    print 'Enter subjects count : '
    count = gets.chomp.to_i
    stu = []
    i=0
    while i < count
      print 'Enter subjects :'
      stu[i] = gets.chomp.to_i
      i+=1
    end
    [count, stu]

  end




  def calling(number)
    (1..number).each do |a|
      count, stu = input
      student = Student_Percentage.new(count,stu)
      student.calculation

    end
  end
end

db = DataInsert.new()
print "Enter data count : "
a  = gets.chomp.to_i
db.calling(a)
