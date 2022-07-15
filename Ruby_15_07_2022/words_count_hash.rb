   print "Enter your String  : "
wordsArray = gets.chomp.to_s.downcase
wordsArray = wordsArray.gsub(/[,.;]/,"").split
ht = Hash.new {|h,k| h[k]=[]}
for i in wordsArray do
	count = 0
    for j in wordsArray do
       if i==j
           count +=1
       end
    end
    if !ht.member?(i)
       ht["#{i}"] << count 
       # ht.store("#{i}", count)
    end
end    
   puts ht.class

ht = ht.sort_by(&:last)
 ht1 = Hash.new {|h1,k1| h1[k1]=[]}
k=ht.length-1
 # puts  a = ht[k][1][0]
while k>=0
   # a = ht[k][1][0]
  # ht1["#{ht[k][0]}"] <<  a 
    ht1.store("#{ht[k][0]}", ht[k][1][0])
 # puts "#{ht[k][0]} : #{ht[k][1][0]}"
 k-=1   
end

puts ht1
puts ht1.class




