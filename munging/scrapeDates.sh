#!/bin/bash
#Usage: ./tabulateBooks.sh tabulatedBooks.csv
: > tempdatesfile #Create empty file
cat $1 |  
while read line; do #for each line in the file do the following
  #The FPAT variable keeps commas inside quotes from being field seperators
  TA=$(echo "$line" | awk -vFPAT='([^,]*)|("[^"]+")' -vOFS=+ \
    '{print $3,$5}') #Title and author's last name
	Stitle=$(echo "$TA" | cut -d"+" -f1) #cut out just the title
	#Now remake $title and $TA with the '+' delimiter replacing spaces
	TA=$(echo $TA | awk -F'[ ]' 'BEGIN{OFS="+";} {$1=$1;print;}')
	title=$(echo $Stitle | awk -F'[ ]' 'BEGIN{OFS="+";} {$1=$1;print;}')


  #sanitizedTitle=$( echo ${Stitle//\"/} ) #Removes " 
  sanitizedTitle=$( echo ${Stitle//\(/\\\(} ) #Replaces ( with \(
  sanitizedTitle=$( echo ${sanitizedTitle//\)/\\)} ) #Replaces ) with \)

	#Look for known dates in file (use perl regex because it works)
  year=$(cat tabulatedBooks_withDates.csv | grep -iP \
    "$sanitizedTitle\,\"([0-9]|\-[0-9])" \
    | awk -vFPAT='([^,]*)|("[^"]+")' '{gsub("\"","",$4); print $4}' )

  #Check if year is in the range 1000 to 2999 CE
	if (echo $year | grep -Eq '^[1-2][0-9][0-9][0-9]$')
	then
    printf 'Known year:%s\n' "$year"
		printf '\"%s\",%s\n' "$year" "$line" >> tempdatesfile
		continue
	fi

  #Check if year is in the range 0 to 999 CE
	if (echo $year | grep -Eq '^[0-9][0-9][0-9]$')
	then
    printf 'Known year:%s\n' "$year"
		printf '\"%s\",%s\n' "$year" "$line" >> tempdatesfile
		continue
	fi

  #Check if year is between 0 and 999 BCE
	if (echo $year | grep -Eq '^\-[0-9][0-9][0-9]$')
	then
    printf 'Known year:%s\n' "$year"
		printf '\"%s\",%s\n' "$year" "$line" >> tempdatesfile
		continue 
  fi

#	if !(echo $year | grep -Eq '^[0-9][0-9][0-9][0-9]$')
#	then
#		year=$(curl --silent --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36" \
#		https://www.google.com/search?q=$TA | \
#		awk -v TA=$TA -f scrapeGoogle.awk)
#	fi

	if !(echo $year | grep -Eq '^[0-9][0-9][0-9][0-9]$')
	then
    echo "Searching for year"
	  #echo "$TA returned -"$year"-, including \"published\" in search string..."
		searchString=$(printf '%s%s' "$TA" "+published")
		year=$(curl --silent --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36" \
		https://www.google.com/search?q=$searchString | \
		awk -f scrapeGoogle.awk)
		#awk -v TA=$TA -f scrapeGoogle.awk)
	  #echo "first if - $year"
	fi
	
#	if !(echo $year | grep -Eq '^[0-9][0-9][0-9][0-9]$')
#	then
#		year=$(curl --silent --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36" \
#		https://www.google.com/search?q=$title | \
#		awk -v TA=$TA -f scrapeGoogle.awk)
#	fi

#	if !(echo $year | grep -Eq '^[0-9][0-9][0-9][0-9]$')
#	then
#		searchString=$(printf '%s%s'"$title""+book")
#		year=$(curl --silent --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36" \
#		https://www.google.com/search?q=$searchString | \
#		awk -v TA=$TA -f scrapeGoogle.awk)
#	fi
	
	if !(echo $year | grep -Eq '^[0-9][0-9][0-9][0-9]$')
	then
		echo "Scraping google failed, trying wolframalpha..."
		searchString=$(printf '%s%s' "\"$title\"" "+first+publication+date")
		year=$(curl --silent --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36" \
		http://www.wolframalpha.com/input/?i=$searchString | \
		awk -f scrapeWolfram.awk)
	#	echo "$searchString"
	#	echo "2nd if - $year"
	fi

	if !(echo $year | grep -Eq '^[0-9][0-9][0-9][0-9]$')
	then
		#make sure $year is empty if it isn't a 4 digit number	
		year=""
		echo "FAILED: $Stitle"
	fi

	printf '\"%s\",%s\n' "$year" "$line" >> tempdatesfile
  
done
: > tempdatesfile2
awk -vOFS="," -vFPAT='([^,]*)|("[^"]+")' \
  '{t=$1; $1=$2; $2=$3; $3=$4; $4=t; gsub(",,",","); \
  print >> "tempdatesfile2"}' tempdatesfile
rm tempdatesfile
mv tabulatedBooks_withDates.csv tabulatedBooks_withDates.csv.backup 
mv tempdatesfile2 tabulatedBooks_withDates.csv

