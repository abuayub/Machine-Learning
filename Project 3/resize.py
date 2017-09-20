# -*- coding: utf-8 -*-

#!/usr/bin/python

import os
import sys
import string
import PIL
import csv
import numpy as np
from PIL import Image
#from resizeimage import resizeimage

fl = open('atthalf.csv', 'w')
writer = csv.writer(fl, delimiter=',', lineterminator='\n')

arr = np.empty((400, 2576), dtype=int)
for s in range(40):
    for p in range(10):
        FILENAME='att_faces\s'+ str(s+1) +'\\'+ str(p+1) +'.pgm'
        image=Image.open(FILENAME)
        #im=cv2.resize(image, (0,0), fx=0.5, fy=0.5) 
        #im = resizeimage.resize_cover(image, [56, 46])
        im = image.resize((56,46), PIL.Image.ANTIALIAS)
        pix=im.load()
        w=im.size[0]
        h=im.size[1]
        print(w)
        print(h)
        for i in range(w):
            for j in range(h):
                arr[s*10+p,i*46+j]=pix[i,j]
print(w)
print(h)
print (arr)
print(arr.shape)
print(np.count_nonzero(arr))
for values in arr:
    writer.writerow(values)
fl.close()  

