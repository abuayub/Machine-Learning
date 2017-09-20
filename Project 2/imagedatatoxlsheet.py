# -*- coding: utf-8 -*-

#!/usr/bin/python

import os
import sys
import string
import PIL
import csv
import numpy as np
from PIL import Image

fl = open('att.csv', 'w')
writer = csv.writer(fl, delimiter=',', lineterminator='\n')

arr = np.empty((400, 10304), dtype=int)
for s in range(40):
    for p in range(10):
        FILENAME='att_faces\s'+ str(s+1) +'\\'+ str(p+1) +'.pgm' #image can be in gif jpeg or png format 
        im=Image.open(FILENAME)
        #im=Image.open(FILENAME).convert('RGB')
        pix=im.load()
        w=im.size[0]
        h=im.size[1]
        for i in range(w):
          for j in range(h):
              arr[s*10+p,i*112+j]=pix[i,j]
print(w)
print(h)
print (arr)
print(arr.shape)
print(np.count_nonzero(arr))
for values in arr:
    writer.writerow(values)
fl.close()  

