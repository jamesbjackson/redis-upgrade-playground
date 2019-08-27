#!/bin/bash
rm -f data.txt
touch data.txt
for i in {1..1000}
do
   echo " SET Key$i Value$i" >> data.txt 
done