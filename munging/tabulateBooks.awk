BEGIN{
FS="\t";
OFS="|";
#lineCount=100 #Number of items in the longest list
lineCount=1 #Number of items in the longest list
}

#FNR<=lineCount{
{
title=toupper($1)
authorLast=$2
authorFirst=$3
#rank=(lineCount-FNR)+51
#bookArray[title]+=rank
bookArray[title]+=1
bookArray2[title]=authorFirst
bookArray3[title]=authorLast
bookArray4[title]=(bookArray4[title] "|" FILENAME)
}



END{
#print "-------------------"
for(b in bookArray2) print bookArray[b],b,bookArray2[b],bookArray3[b],bookArray4[b]
}
