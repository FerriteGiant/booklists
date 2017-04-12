#!/usr/bin/awk
BEGIN{
RS="<[^>]+>";
OFS="+";
ORS="";
}

#/data not available/{
#	err=sprintf("\n%s\n%s%s","Data not available.",\
#	"Search string used: ",sstring)
#	print err > "/dev/stderr"
#

/Published/{
if ($0=="Published")
	pubNR=NR
else
	next
}


NR==pubNR+4{
dateArrayLength=split($0,dateArray," ")
year=dateArray[dateArrayLength]
print year
}

#{$1=$1;print > "googleScrapings/"TA}
