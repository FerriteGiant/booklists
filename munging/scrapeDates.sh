#!/bin/bash
: > tempdatesfile
cat $1 |  
while read line; do #for each line in the file do the following
	TA=$(echo "$line" | cut -d"|" -f2,4) #cut out the title and surname
	Stitle=$(echo "$line" | cut -d"|" -f2) #cut out just the title
	#Now remake $title and $TA with the '+' delimiter replacing spaces
	TA=$(echo $TA | awk -F'[ |]' 'BEGIN{OFS="+";} {$1=$1;print;}')
	title=$(echo $Stitle | awk -F'[ |]' 'BEGIN{OFS="+";} {$1=$1;print;}')

	#Something in the following line fucks up VIM's text coloring
  #Uncomment before running
	sanitizedTitle=$( echo ${Stitle//\(/\\(} )
	sanitizedTitle=$( echo ${sanitizedTitle//\)/\\)} )

	
	#Look for known dates in file (use perl regex for tab chars)
	year=$(cat tabulatedDates.dat | grep -Pi "[0-9]\t$sanitizedTitle\t" | cut -f5)
  printf '%s\n' "$year"
	
	if (echo $year | grep -Eq '^[0-9][0-9][0-9][0-9]$')
	then
		printf '%s|%s\n' "$year" "$line" >> tempdatesfile
		continue
	fi

	if (echo $year | grep -Eq '^\-[0-9][0-9][0-9]$')
	then
		printf '%s|%s\n' "$year" "$line" >> tempdatesfile
		continue
	fi

	if !(echo $year | grep -Eq '^[0-9][0-9][0-9][0-9]$')
	then
		year=$(curl --silent --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36" \
		https://www.google.com/search?q=$TA | \
		awk -v TA=$TA -f scrapeGoogle.awk)
	fi

	if !(echo $year | grep -Eq '^[0-9][0-9][0-9][0-9]$')
	then
	#	echo "$TA returned -"$year"-, including \"published\" in search string..."
		searchString=$(printf '%s%s' "$TA" "+published")
		year=$(curl --silent --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36" \
		https://www.google.com/search?q=$searchString | \
		awk -v TA=$TA -f scrapeGoogle.awk)
	#	echo "first if - $year"
	fi
	
	if !(echo $year | grep -Eq '^[0-9][0-9][0-9][0-9]$')
	then
		year=$(curl --silent --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36" \
		https://www.google.com/search?q=$title | \
		awk -v TA=$TA -f scrapeGoogle.awk)
	fi

	if !(echo $year | grep -Eq '^[0-9][0-9][0-9][0-9]$')
	then
		searchString=$(printf '%s%s'"$title""+book")
		year=$(curl --silent --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36" \
		https://www.google.com/search?q=$searchString | \
		awk -v TA=$TA -f scrapeGoogle.awk)
	fi
	
	if !(echo $year | grep -Eq '^[0-9][0-9][0-9][0-9]$')
	then
	#	echo "Scraping google failed, trying wolframalpha..."
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

	printf '%s|%s\n' "$year" "$line" >> tempdatesfile
done
#mv tabulatedDates.dat tabulatedDates.backup.dat
mv tempdatesfile tabulatedBook_withDates.csv
