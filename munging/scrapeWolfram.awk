#!/usr/bin/awk
BEGIN{
FS="\"";
OFS="";
}

#/Using closest Wolfram || doesn't understand your query/{
#	err=sprintf("\n%s\n%s%s\n%s\n","Input not interpreted correctly.",\
#	"Search string used: ",sstring,"Enter \"skip\" or a new search string: ")
#	print err > "/dev/stderr"
##	
##	command="./scrapeWolframErr.sh"
##	while ( (command | getline year) > 0) { 
##	    print year 
##	} 
##	close(command) 	
#	next
#	}
#
#/data not available/{
#	err=sprintf("\n%s\n%s%s","Data not available.",\
#	"Search string used: ",sstring)
#	print err > "/dev/stderr"
#
/stringified/{
c++;
if(c==2){
	dateArrayLength=split($4,date," ")
	year=date[dateArrayLength]
	print year
	}


}

