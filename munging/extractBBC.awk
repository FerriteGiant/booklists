#!/usr/bin/awk
#awk -f extractBBC.awk -f extraFunctions.awk bbc_the_big_read.txt
#Source: http://www.listsofbests.com/list/60-the-big-read-books-1-100
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

/name/{

title=$4;
author=$5;

numNames=split(author,authorNameArray," ");
firstNames=join(authorNameArray,1,numNames-1);
#rank=weightBook(lineCount,rankIterator++);
print title,authorNameArray[numNames],firstNames > outputFile;
}
