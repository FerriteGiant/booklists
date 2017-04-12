#!/usr/bin/awk
#awk -f extractBL.awk -f extraFunctions.awk bookman_librarians.html
#Source: http://www.the-bookman.com/main/Best.books.html
BEGIN{
FS="++";
OFS="\t";
lineCount=100;
rankIterator=0;
}

FNR==1{
split(FILENAME,fileNameArray,".");
outputFile = fileNameArray[1]".table"; 
}

{
title=$1;
author=$2;
#numNames=split(author,authorNameArray," ");
#firstNames=join(authorNameArray,1,numNames-1);
#rank=weightBook(lineCount,rankIterator++);
print title,author,"null" > outputFile;
}
