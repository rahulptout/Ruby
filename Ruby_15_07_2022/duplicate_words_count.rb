# @wordArray = []
#    print "Enter a String :  "
   # content = "A paragraph is a series of sentences that are organized and coherent, and are all related to a single topic. Almost every piece of writing you do that is longer than a few sentences should be organized into paragraphs. This is because paragraphs show a reader where the subdivisions of an essay begin and end, and thus help the reader see the organization of the essay and grasp its main points."
# 	# content = gets.chomp.to_s
# 	content =content.downcase 
# 	content = content.gsub(/[,.;]/,"")
# 	@wordArray = content.split
# 	 # puts @wordArray

   
print "Enter your String  : "
wordsArray = gets.chomp.to_s.downcase
wordsArray = wordsArray.gsub(/[,.;]/,"").split

keys =[]
# values = []
# ht = Hash.new {|h,k| h[k]=[]}
for i in wordsArray do
	count = 0
    for j in wordsArray do
       if i==j
           count +=1
       end
    end
    # ht["#{count}"] << "#{i}"
    keys.push("#{i} : #{count}")
    # values.push(i)
end    


# ht.each do |key, value|
#     puts "#{key} = #{value}"
# end
keys = keys.uniq
keys = keys.sort_by { |s| s.scan(/\d+/).first.to_i }
# puts keys
k=keys.length-1
# puts k
while k>=0
	puts "#{keys[k]}"
	k-=1
	
end




