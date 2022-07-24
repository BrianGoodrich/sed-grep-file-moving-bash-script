#!/bin/bash
#Brian Goodrich - The purpose of this script is to take a text file insert a header and copy to a file named move1.txt, duplicate the file in a file called move2.txt with Hauschild changed to Housechild, place donors names in a file called move3.txt that have a phone number starting with 916, move donors that names begin with M or R to move4.txt, and place the name and phone number of donors that donated more than $500 in any single month into a file called move5.txt.

textFile=$1

if [[ $# -lt 1 ]]; then
    printf "Not enough arguments: expects one text file to read from."
    exit
fi

if [[ ! -f ./$textFile ]]; then
    printf "$textFile does not exist \n"
    exit
fi

sed '1i  Name 	   Phone Number	   Jan	  Feb	  Mar' $textFile >move1.txt

sed 's/Hauschild/Housechild/g' $textFile >move2.txt

grep '(916)' $textFile | sed 's/[^A-Z]/ /Ig' >move3.txt

grep '^[MR]' $textFile | sed 's/\s.*//g' >move4.txt

sed 's/,/ /g' $textFile | sed 's/[\$][0-9]\.[0-9][0-9]//g' | sed 's/[\$][0-9][0-9]\.[0-9][0-9]//g' | sed 's/[\$][0-4][0-9][0-9]\.[0-9][0-9]//g' | grep [\$] | sed 's/[\$].*[0-9]//g' | sed 's/\s/,/' | sed -E 's/^(.*),([^ ]*)/\2 \1/' >move5.txt
