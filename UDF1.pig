import '/home/shashank/Desktop/Hadoopprac/PigScript/groupkeyudf.macro';
newrecord = LOAD '/home/shashank/Desktop/rough.txt' using PigStorage(',') as (firstname:chararray,lastname:chararray,city:chararray,gender:chararray,cgpa:double,college:chararray);
order_data = order newrecord by cgpa asc;
group_data = max_by_group(order_data,city);
data_top = foreach group_data{
top = Top(1,5,order_data); 
generate flatten(top);
}
dump data_top;
--pig -x local /home/shashank/Desktop/Hadoopprac/PigScript/UDF1.pig;
