import qrcode

img = qrcode.make('https://www.blog.pythonlibrary.org')
img.save("some_file.png")
