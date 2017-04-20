#!/usr/bin/awk
BEGIN{
RS="<[^>]+>"; #Make each HTML tag a row divider
OFS="+";
ORS="";
}

#/data not available/{
#	err=sprintf("\n%s\n%s%s","Data not available.",\
#	"Search string used: ",sstring)
#	print err > "/dev/stderr"
#

/Originally published/{
if ($0=="Originally published") #Did it work?
	pubNR=NR #Remember row number
else
	next #No luck, proceed to next book
}


NR==pubNR+3{ #Date will be 3 rows after the 'originally published' text
dateArrayLength=split($0,dateArray," ")
year=dateArray[dateArrayLength] #Pull out just the year
print year
}

#{$1=$1;print > "googleScrapings/"TA}
