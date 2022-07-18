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
    # puts "student percentage : #{@per}%"
    case @per
    when 0..33
      puts "student percentage : #{@per}% grade -- F"
    when 34..59
      puts "student percentage : #{@per}% grade -- E"
    when 60..74
      puts "student percentage : #{@per}% grade -- C"
    when  75..84
      puts "student percentage : #{@per}% grade -- B"
    when  85..94
      puts "student percentage : #{@per}% grade -- A"
    when 95..100
      puts "student percentage : #{@per}% grade -- A+"
    end
  end
end




class DataInsert
  def studentDataInsert

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




  def ObjectCreate(number)
    (1..number).each do |a|
      count, stu = studentDataInsert
      student = Student_Percentage.new(count,stu)
      student.calculation

    end
  end
end

datainsert = DataInsert.new()
print "Enter data count : "
a  = gets.chomp.to_i
datainsert.ObjectCreate(a)
