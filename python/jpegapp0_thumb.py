import sys, os
import cv2
import numpy as np
import struct

def insertThumbnail(infile, thumbfile):
    with open(infile, "rb") as f:
        fist4bytes = f.read(4)
        if fist4bytes != b"\xff\xd8\xff\xe0":
            print("APP0 not found")
            return False;
        im = cv2.imread(thumbfile, cv2.IMREAD_COLOR)
        if im is None:
            print("thumbnail file not found")
            return False;
        (height, width, comp) = im.shape
        arr = np.ravel(im)  # volume array to flatten
        app0first2bytes = f.read(2)  # app0 size
        app0next12bytes = f.read(12)  # app0
        app0last2bytes = f.read(2)  # app0 thumbnail size XY
        app0size = 16 + 3 * width * height;
        if 0xFF < width or 0xFF < height or 0xFFFF < app0size:
            print("255 < width({}) or 255 < height({}) or 65535 < app0size({})".format(width, height, app0size))
            return False;
        thumbX = struct.pack("B", width)
        thumbY = struct.pack("B", height)
        imRGB = cv2.cvtColor(im, cv2.COLOR_BGR2RGB)
        thumbData = imRGB.tobytes()
        # print("thumbX,Y", thumbX, thumbY, thumbData)
        # print("app0size", app0size)
        app0first2bytes = struct.pack(">H", 3 * width * height)
        # output
        for d in [fist4bytes,
                  app0first2bytes, app0next12bytes, thumbX, thumbY, thumbData]:
            sys.stdout.buffer.write(d)
        sys.stdout.buffer.write(f.read())
        return True
            
def extractThumbnail(infile):
    with open(infile, "rb") as f:
        fist4bytes = f.read(4)
        if fist4bytes != b"\xff\xd8\xff\xe0":
            print("APP0 not found")
            return False;
        app0first2bytes = f.read(2)  # app0 size
        app0next12bytes = f.read(12)  # app0
        app0last2bytes = f.read(2)  # app0 thumbnail size XY
        width, height = struct.unpack("2B", app0last2bytes)
        thumbData = f.read(3 * width * height)
        arr = np.frombuffer(thumbData, dtype=np.uint8)        
        img = arr.reshape((height, width, 3))
        imgBGR = cv2.cvtColor(img, cv2.COLOR_RGB2BGR)
        # print(width, height, im.shape)
        sys.stdout.buffer.write(cv2.imencode(".png", imgBGR)[1].tobytes())
    return True
    
thumbfile = None

if len(sys.argv) < 2:
    prog = sys.argv[0]
    print("Usage: {} [jpegfile [thumbfile]]".format(prog))
    print("Usage: {} input.jpg  # extract thumb image".format(prog))
    print("Usage: {} input.jpg thumb.png  # insert thumb image".format(prog))
elif len(sys.argv) < 3:
    prog, infile = sys.argv
    ret = extractThumbnail(infile)
    if not ret:
        exit (1)
else:
    prog, infile, thumbfile = sys.argv
    ret = insertThumbnail(infile, thumbfile)
    if not ret:
        exit (1)

exit (0)

