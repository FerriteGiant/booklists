#!/usr/bin/awk
#awk -f extractTIME.awk -f extraFunctions.awk time.html
#Source: http://entertainment.time.com/2005/10/16/all-time-100-novels/

#NOTE THAT THESE BOOKS ARE NOT IN ANY RANKED ORDER

BEGIN{
FS=" - ";
OFS="\t";
lineCount=100;
rankIterator=0;
}

FNR==1{
split(FILENAME,fileNameArray,".");
outputFile = fileNameArray[1]".table"; 
}

{
title=$3;
author=$2;
numNames=split(author,authorNameArray," ");
firstNames=join(authorNameArray,1,numNames-1);
#rank=weightBook(lineCount,rankIterator++);
print title,authorNameArray[numNames],firstNames,"100" > outputFile;
}
