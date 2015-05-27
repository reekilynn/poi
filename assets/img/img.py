# !/usr/bin/env python
# coding: utf-8
from PIL import Image, ImageFilter
import os, sys
import os.path
picture = { ".png", ".jpeg", ".jpg" }
pictureDir = "./slotitem/"

for now in os.listdir(pictureDir):
  f, e = os.path.splitext(pictureDir + now)
  if e.lower() in picture:
    outPath = pictureDir + now
    image = Image.open(outPath)
    w, h = image.size
    if w == 36 and h == 36:
      pass
    else:
      print now, w, h