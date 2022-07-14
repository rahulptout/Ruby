@wordArray
aFile = File.new("Paragraph.txt","r")
if aFile 
	content = aFile.sysread(aFile.size)
	content =content.downcase 
	content = content.gsub(/[,.;]/,"")
    # puts content
	 @wordArray = content.split
	 # puts @wordArray


else 
   puts "Unable to open file!"

   	end


@i=0
@j=0
@wordCount=0
while @i<=@wordArray.length()
	while @j<=@wordArray.length()
   	if @wordArray[@j]==@wordArray[@i]
        @wordCount+=1
       puts "#{@wordCount}"
		
	   end
	   @j+=1
 
end 
    ky = @wordCount
    val = @wordArray[@i]
    h =Hash.new("#{ky}"=>val)
	@i+=1
	puts @wordArray[@i]
end


puts "#{h[0]}"

