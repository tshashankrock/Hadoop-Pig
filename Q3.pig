newrecord = LOAD '/home/shashank/Desktop/rough.txt' using PigStorage(',') as (firstname:chararray,lastname:chararray,city:chararray,gender:chararray,cgpa:double,college:chararray);
group_data = group newrecord by city;
data_top = foreach group_data {
generate group,AVG(newrecord.cgpa);
}
dump data_top;

