#analyzeData.py
#
#

import sys
import numpy as np
import matplotlib.pyplot as plt

fileName = str(sys.argv[1])
adjRank = []
rawRank = []

f = open(fileName,'r')
for line in f:
	adjRank.append(float(line.split()[0]))
	rawRank.append(float(line.split()[1]))

plt.plot(adjRank[0:150],'r^')
plt.plot(sorted(rawRank,reverse=True)[0:150],'b^')
plt.show()
