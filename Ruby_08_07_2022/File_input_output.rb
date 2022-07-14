# puts "Enter a value :"

# val = gets.chomp.to_i
# Thread.new {gets.chomp}

# puts vala


# # sysread
# aFile = File.new("textfile.txt","r")
# if aFile 
# 	content = aFile.sysread(500)
# 	puts content

# else 
#    puts "Unable to open file!"

#    	end


# # syswrite method
# aFile = File.new("textfile.txt","r+")
# if aFile 
# 	aFile.syswrite("rahul pal")

# else 
#    puts "Unable to open file!"

#    	end


# # each_byte method
# aFile = File.new("textfile.txt","r+")
# if aFile 
# 	aFile.syswrite("Rahul")
# 	aFile.each_byte {|ch| putc ch; putc ?~ }
	

# else 
#    puts "Unable to open file!"

#    	end


# IO.readlines method

# arr = IO.readlines("textfile.txt")
# puts arr[0]
# puts arr[1]

# OI.foreach method
# IO.foreach("textfile.txt") { |block| puts block}


# File.rename("test1.txt" , "test2.txt")


# File.delete("test2.txt")


# file = File.new("test.txt", "w")
# file.chmod( 0755 )


# # The following command tests whether a file exists before opening it
# File.open("file.rb") if File::exists?( "file.rb" )


# # file is existing or not 
# value= File.file?( "textfile.txt" ) 
# puts value

# values=File::directory?("/Desktop/Ruby/Ruby_08_07_2022")
# puts values

# values1 = File::directory?("Arrays.rb")
# puts values1

# File.readable?("textfile.txt")
# File.writable?("textfile.txt")
# File.executable?("textfile.txt")


# puts File.zero?("text.txt")


# puts File.size?("textfile.txt")

# puts File::ctime( "textfile.txt" ) 
# puts File::mtime( "textfile.txt" ) 
# puts File::atime( "textfile.txt" )

