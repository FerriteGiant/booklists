#join an array into a string
#An optional additional argument is the separator to use 
#when joining the strings back together. If the caller 
#supplies a nonempty value, join() uses it; if it is not 
#supplied, it has a null value. In this case, join() uses 
#a single space as a default separator for the strings. 
#If the value is equal to SUBSEP, then join() joins the 
#strings with no separator between them. SUBSEP serves 
#as a “magic” value to indicate that there should be no 
#separation between the component strings.
function join(array, start, end, sep,    result, i)
{
    if (sep == "")
       sep = " "
    else if (sep == SUBSEP) # magic value
       sep = ""
    result = array[start]
    for (i = start + 1; i <= end; i++)
        result = result sep array[i]
    return result
}


function weightBook(lineCount,rankIterator,    result)
{
	result=(lineCount-rankIterator)+50
	return result
}
