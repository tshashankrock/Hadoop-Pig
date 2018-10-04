newrecord = LOAD '/home/shashank/Desktop/rough.txt' using PigStorage(',') as (firstname:chararray,lastname:chararray,city:chararray,gender:chararray,cgpa:double,college:chararray);
order_data = order newrecord by cgpa asc;
group_data = group order_data by city;
data_top = foreach group_data {
top = TOP(1,5,order_data);
generate flatten(top);
}
dump data_top;
--pig -x local /home/shashank/Desktop/Hadoopprac/PigScript/Q1.pig;


