#!/usr/bin/awk
#awk -f extractMLV.awk -f extraFunctions.awk modern_library_xxx.html
#Source: http://www.modernlibrary.com/top-100/100-best-novels/
#	 http://www.modernlibrary.com/top-100/radcliffes-rival-100-best-novels-list/
BEGIN{
FS="<[^>]+>| by ";
OFS="\t";
lineCount=100;
rankIterator=0;
}

FNR==1{
split(FILENAME,fileNameArray,".");
outputFile = fileNameArray[1]".table"; 
}

{
#title=$3
#if($3=="") title=$4;
#author=$5;
#if($5=="") author=$7;

title=$2
author=$4

numNames=split(author,authorNameArray," ");
firstNames=join(authorNameArray,1,numNames-1);
#rank=weightBook(lineCount,rankIterator++);
print title,authorNameArray[numNames],firstNames > outputFile;
}
