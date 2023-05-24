# pip install PyPDF2
# pip install pyttsx3

#importing the modules
import PyPDF2,pyttsx3

# PDF file
path = open('clcoding.pdf','rb')

# creating a PdfFileReader object
pdfReader = PyPDF2.PdfFileReader(path)

# Get an engine instance for the speech synthesis
speak = pyttsx.3.init()

for pages in range(pdfReader.numPages):
    text = pdfReader.getPage(pages).extractText()
    speak.say(text)
    speak.runAndWait()
speak.stop()
#clcoding.com
