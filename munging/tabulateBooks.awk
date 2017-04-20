BEGIN{
FS="\t"; #Input delimiter
OFS=","; #Output delimiter
lineCount=100 #Number of items in the longest list
}

{ #for every line in each file
title=toupper($1)
authorLast=$2
authorFirst=$3
rank=lineCount-(FNR-1)
#bookArray[title]+=rank
NumOfListsArray[title]+=1
FirstNameArray[title]=authorFirst
LastNameArray[title]=authorLast
#Pull out filename sans extension 
len = split(FILENAME,N1,"/")
split(N1[len],N2,".")
listName = N2[1]
#Append which lists the book appears in and the rank it has in that list
FileNameArray[title]=(FileNameArray[title] "\",\"" listName "\",\"" rank)
totalRankArray[title]=(totalRankArray[title] + rank)
}



END{
#print "-------------------"
for(title in FirstNameArray) {
  gsub(/^\",\"/,"",FileNameArray[title]) #Remove extra delimter 
  # Number of lists book is in, book title, author first name, last name, lists in which book appears and rank in that list
  print "\""NumOfListsArray[title]"\"","\""totalRankArray[title]"\"","\""title"\"","\""FirstNameArray[title]"\"","\""LastNameArray[title]"\"","\""FileNameArray[title]"\""
  }
}
