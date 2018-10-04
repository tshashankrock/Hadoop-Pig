newrecord = LOAD '/home/shashank/Desktop/Hadoopprac/PigScript/inp' using PigStorage(';') as (name:chararray,age:int,cgpa:double,city:chararray,gender:chararray);
filter_data1 = FILTER newrecord by (gender == 'male') AND (name != '');
filter_data2 = FILTER newrecord by (gender == 'female') AND (name != '');
rough1 = foreach filter_data1 generate city,name,gender;
rough2 = foreach filter_data2 generate city,name,gender;
--final_data = join rough1 by city, rough2 by city;
final_data = COGROUP rough1 by city,rough2 by city;
final_res = foreach final_data generate (group,rough1.name);
dump final_res;
final_res1 = foreach final_data generate (group,rough2.name);
dump final_res1;
--pig -x local /home/shashank/Desktop/Hadoopprac/PigScript/matrimonial.pig;