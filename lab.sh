#!/bin/bash          

#TASK1                                                                                                                                  
if [ $# -ne 2 ];         
then                                                                                                                                                           
	echo                                                                                                                                                   
	echo "Input names of two files"                                                                                                                        
	echo "First being the input file, and second the output file in which to be written."                                                                  
	echo                                                                                                                                                   
	exit 1                                                                                                                                         
fi            

#TASK2                                                                                                                                         
[ -f "$1" ]                                                                                                                                            
#echo $?                                                                                                                                               
if [ $? -eq 1 ];                                                                                                                                       
then                                                                                                                                                           
	echo                                                                                                                                                   
	echo "$1 does not exist"                                                                                                                              
	echo                                                                                                                                                   
	exit 1                                                                                                                                         
fi     
                                                                                                                                                                 
#TASK3                                                                                                                                      
#sed "s/,/ /g" $1 > $2                                                                                                                                 
awk -F "," '{print $1,$2,$3,$5,$6,$7,$10,$11}' $1 > $2                                                                                                                  

#TASK4                                                                                                                                      
#cat $2                                                                                                                                                
touch geo1.txt                                                                                                                                                                                                                                                                                         
echo >> $2                                                                                                                                             
echo "Name of the colleges whose Highest Degree is Bachelor’s are: " >> $2                                                                                                                                                                                                                                    
#IFS = ','                                                                                                                                             
while read line; do                                                                                                                                            
	IFS=','                                                                                                                                                
	read -a fields <<< "$line"                                                                                                                             
	if [ ${fields[2]} = "Bachelor's" ]; then                                                                                                                   
		echo ${fields[0]} >> $2 
        fi                                                                                                                                                         
	echo ${fields[5]} >> geo1.txt                                                                                                          
done < $1  

#TASK5                                                                                                                                   
touch geo2.txt                                                                                                                                         
cat geo1.txt | sort -u > geo2.txt                                                                                                                      
sed '/Geography/d' geo2.txt > geo1.txt                                                                                                                 
#cat geo1.txt                                                                                                                                                                                                                                                                                                 
echo >> $2                                                                                                                                             
echo "Geography: Average Admission Rate" >> $2                                                                                                                                                                                                                                                                
while read line1;do                                                                                                                                            
	sum=0                                                                                                                                                  
	count=0                                                                                                                                                
	while read line2; do                                                                                                                                    
		IFS=','                                                                                                                                           
		read -a fields <<< "$line2"                                                                                                                          
		if [ ${fields[5]} = $line1 ]; then                                                                                                                
			sum=$(bc -l <<< "${sum}+${fields[6]}")                                                                                                  
			count=$(( $count + 1 ))                                                                                                                     
		fi                                                                                                                                             
	done < $1                                                                                                                                              
	avg=$(bc -l <<< "scale=4; ${sum}/${count}")                                                                                                            
	#echo $avg                                                                                                                                             
	echo "$line1: 0$avg" >> $2                                                                                                                     
done < geo1.txt                                                                                                                                                                                                                                                                                               
rm geo1.txt                                                                                                                                            
rm geo2.txt                                                                                                                                                                  
#TASK6                                                                                                                                 
echo >> $2                                                                                                                                             
echo "Top 5 Colleges with maximum Median Earnings: " >> $2                                                                                             
echo "Name: MedianEarnigs" >> $2
touch MedEarn.txt                                                                                                                                      
awk -F "," '{print $NF","$1}' $1 | sort -nr | head -5 > MedEarn.txt                                                                                    
awk -F "," '{print $NF": "$1}' MedEarn.txt >> $2                                                                                                       
rm MedEarn.txt                                                                                                                                                                                                                                                                                                
#cat $2    