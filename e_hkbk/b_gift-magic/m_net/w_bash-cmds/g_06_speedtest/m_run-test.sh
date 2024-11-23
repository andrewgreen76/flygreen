outfile="n_reports.txt"

echo | tee -a $outfile
date | tee -a $outfile
echo | tee -a $outfile 
speedtest-cli | tee -a $outfile
echo | tee -a $outfile
echo | tee -a $outfile
echo | tee -a $outfile
