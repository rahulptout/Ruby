@wordArray
aFile = File.new("Paragraph.txt","r")
if aFile 
	content = aFile.sysread(aFile.size)
	content =content.downcase 
	content = content.gsub(/[,.;]/,"")
    # puts content
	 @wordArray = content.split
	 puts @wordArray


else 
   puts "Unable to open file!"

   	end

h =Hash.new("#{ky}"=>val)
i=0
while i<=wordArray.length()
	while j<=wordArray.length()
	if wordArray[i]==wordArray[j]
        

		
	end
end
	
end




