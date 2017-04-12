#!/usr/bin/awk
#awk -f extract<name>.awk -f functionLibrary.awk <name>.html
#Source: http://www.goodreads.com/list/show/13086.Goodreads_Top_100_Literary_Novels_of_All_Time 
BEGIN{
FS="<[^>]+>";
OFS="\t";
lineCount=100;
rankIterator=0;
}

FNR==1{
split(FILENAME,fileNameArray,".");
outputFile = fileNameArray[1]".table"; 
}

/itemprop='name'/{
title=$2
#print FNR,title
}

/class="authorName"/{
author=$3
#print FNR,author
currentLine=FNR
}
FNR==currentLine{
numNames=split(author,authorNameArray," ");
firstNames=join(authorNameArray,1,numNames-1);
#rank=weightBook(lineCount,rankIterator++);
print title,authorNameArray[numNames],firstNames > outputFile;
}
