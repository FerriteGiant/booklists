#!/usr/bin/python

import sys

#####################################

def jaccard_index(set_1,set_2):
	n = len(set_1.intersection(set_2))
	return n / float(len(set_1) + len(set_2) - n)

#####################################

fileName=str(sys.argv[1])

shingleLen=4

with open(fileName,'r') as f:

  data = f.readlines()
  
  lineNumA=0
  for line in data:
    line=line.rstrip('\n')
    primaryShingle=[line[i:i + shingleLen] for i in range(len(line) - shingleLen + 1)]
    primarySet=set(primaryShingle)
    
    lineNumB=0
    for ll in data:
      if lineNumA < lineNumB:
        ll=ll.rstrip('\n')
        secondaryShingle=[ll[k:k + shingleLen] for k in range(len(ll) - shingleLen + 1)]
        secondarySet=set(secondaryShingle)
        
        jac = jaccard_index(primarySet,secondarySet)
        if jac > .35:
          print "%.3f\n%s\n%s"%(jac,line,ll)
          print "-----------"
      #print lineNumB
      lineNumB += 1
    #print lineNumA
    lineNumA += 1
    
    
