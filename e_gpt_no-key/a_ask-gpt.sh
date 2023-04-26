emacs seg_d_req.curl
echo -e "\n" >> transcript.txt
echo -e "\n" >> transcript.txt
cat seg_d_req.curl                   # reflects query
cat seg_d_req.curl >> transcript.txt # moves query to transcript
echo -e "\n" >> transcript.txt
echo -e "\n" >> transcript.txt
cat seg_a_head.curl >> req_in_ba.sh
cat seg_b_head.curl >> req_in_ba.sh
cat seg_c_head.curl >> req_in_ba.sh
cat seg_d_head.curl >> req_in_ba.sh
cat seg_e_head.curl >> req_in_ba.sh # POST request assembled 
bash req_in_ba.sh >> transcript.txt
cd ..
git add *
git commit -m "x"
git push
cat transcript.txt
