echo 
echo \> Hi. I\'m not home right now, but if you want to leave a message, just start talking at the sound of the tone. 
echo 
echo \> Hello?
echo \> This is your mother. Are you there?
echo \> Are you coming home?
echo 
echo
echo Using the \'expr\' command: 
result=$(expr 2 + 3)
echo $result
echo
echo Using the ARITHMETIC expansion: 
result=$((2 + 3))
echo $result
echo
echo Perform operations inside other operations:
echo "$((5 + 6 * 2))"
echo
