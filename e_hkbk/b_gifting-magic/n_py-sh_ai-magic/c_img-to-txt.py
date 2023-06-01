from PIL import Image
import pytesseract

image = Image.open(image_file)
image = image.convert("L")  # convert to grayscale
image = image.point(lambda x: 0 if x < 128 else 255, "1")  # apply thresholding
text = pytesseract.image_to_string(image)
