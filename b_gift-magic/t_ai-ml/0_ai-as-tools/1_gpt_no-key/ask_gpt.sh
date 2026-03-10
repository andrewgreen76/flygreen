emacs segd.curl               # general user enters query
echo -e "\n"
echo -e "\n" >> transcript.txt
cat segd.curl                   # reflects query
cat segd.curl >> transcript.txt # moves query to transcript
echo -e "\n"
echo -e "\n" >> transcript.txt
cat sega.curl > reqinba.sh # head piece
cat segb.curl >> reqinba.sh # private openai key
cat segc.curl >> reqinba.sh # middle piece
cat segd.curl >> reqinba.sh # human req piece
cat sege.curl >> reqinba.sh # tail piece ; POST request composed
#bash reqinba.sh # process the request , get the output
bash reqinba.sh | tee -a transcript.txt # bash within bash is allowed 
echo -e "\n"
echo -e "\n" >> transcript.txt
#cd ..
#git add *
#git commit -m "x"
#git push
#cat transcript.txt
