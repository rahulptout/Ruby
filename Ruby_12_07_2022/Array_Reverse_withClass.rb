class Demo2 

def Array_Reverse(array)

array1 = []
print array
i=array.length()-1
j=0
while i>=0
	array1[j]=array[i]
	i-=1
	j+=1

end
 print array1	
end

end


array = [1,2,3,4,5,6,7]
demo2  = Demo2.new()
demo2.Array_Reverse(array)