
import sys
import csv
import numpy as np
import matplotlib.pyplot as plt
import time
import math as m

def importData(fileName):

  dataArray=[]
  file=open(fileName,'rb')
  data = csv.reader(file,delimiter="\t")
  for row in data:
    dataArray.append(row[4]) 
  file.close()
  
  dataArray=np.array(dataArray).astype(int)
  
  return dataArray
dates = importData("tabulatedDates.dat")

print "Dates before 1600"
print [x for x in dates if x< 1600]
#dates = [x for x in dates if x>=1600]
#dates = dates[0:200]


#print binDivs
#binDivs=np.array([1600,1700]+range(1800,2021,10))
binDivs=np.array(range(1600,2021,10))
plt.hist(dates,bins=(binDivs),width=10,label=["Books"])
#new,=plt.plot(newDeadChDates,newDeadCh[:,0],'ro')
#known,=plt.plot(knownDeadChDates,knownDeadCh[:,0],'ks')
plt.xticks(binDivs,rotation=75)
plt.xlim([1600,2020])
plt.minorticks_on()
plt.tick_params(axis='x',which='minor',bottom='off')
#my_xticks = []
#for xtic in binDivs:
#  my_xticks.append(str(int(m.floor(xtic)))+":"+str(int((xtic-m.floor(xtic))*60)).zfill(2))
#plt.xticks(binDivs, my_xticks)

plt.grid(True,axis='y',which='both')
plt.xlabel("Year")
plt.ylabel("Number of books published druing this period")
plt.title("Published year of recommended books")
#plt.legend()
#plt.legend([bad,new,known],('Bad','New Dead','Known Dead'),'best',numpoints=1,
#  bbox_to_anchor=(0.9,1.05),fancybox=True,shadow=True)
#
plt.show()







