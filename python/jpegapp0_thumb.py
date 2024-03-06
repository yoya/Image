import sys, os, math, struct
import cv2
import numpy as np


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
        app0size = 16 + 3 * width * height;
        if 0xFF < width or 0xFF < height or 0xFFFF < app0size:
            # aspect を維持して画像を縮小
            if 0xFF < width:
                height = math.floor(height * 0xFF / width)
                width = 0xFF
            if 0xFF < height:
                width = math.floor(width * 0xFF / height)
                height = 0xFF
            app0size = 16 + 3 * width * height;
            if 0xFFFF < app0size:
                app0size = 16 + 3 * width * height;
                scale = math.sqrt(0xFFFF / app0size)
                width = math.floor(width * scale)
                height = math.floor(height * scale)
            im = cv2.resize(im, (width, height))
        app0size = 16 + 3 * width * height;
        if 0xFFFF < app0size:  # 念の為
            print("width({}), heighg({}), 65535 < app0size({})".format(width, height, app0size))
            return False;
        arr = np.ravel(im)  # volume array to flatten
        app0first2bytes = f.read(2)  # app0 size
        app0next12bytes = f.read(12)  # app0 payload middle
        app0last2bytes = f.read(2)  # app0 thumbnail size XY
        thumbX = struct.pack("B", width)
        thumbY = struct.pack("B", height)
        imRGB = cv2.cvtColor(im, cv2.COLOR_BGR2RGB)
        thumbData = imRGB.tobytes()
        app0first2bytes = struct.pack(">H", 16 + 3 * width * height)
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
        im = arr.reshape((height, width, 3))
        imBGR = cv2.cvtColor(im, cv2.COLOR_RGB2BGR)
        # print(width, height, im.shape)
        sys.stdout.buffer.write(cv2.imencode(".png", imBGR)[1].tobytes())
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

