#!/usr/bin/awk
#awk -f extractBBC.awk -f extraFunctions.awk bbc_the_big_read.txt
#Source: http://www.npr.org/templates/story/story.php?storyId=106983620
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

{
title=$2;
author=$3;
numNames=split(author,authorNameArray," ");
firstNames=join(authorNameArray,1,numNames-1);
#rank=weightBook(lineCount,rankIterator++);
print title,authorNameArray[numNames],firstNames > outputFile;
}
