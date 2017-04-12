#!/usr/bin/awk
#awk -f extractHBS.awk -f extraFunctions.awk harvard_bookstore.html
#Source: http://www.harvard.com/shelves/top100/
BEGIN{
FS=" - ";
OFS="\t";
#lineCount=100;
#rankIterator=0;
}

FNR==1{
split(FILENAME,fileNameArray,".");
outputFile = fileNameArray[1]".table";
}

/Title/{
title=$2;
}

/by/{
author=$2
numNames=split(author,authorNameArray," ");
firstNames=join(authorNameArray,1,numNames-1);
print title,authorNameArray[numNames],firstNames > outputFile;
}
