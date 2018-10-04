newrecord = LOAD '/home/shashank/Desktop/input' using PigStorage(',') as (firstname:chararray);
words = foreach newrecord generate flatten(TOKENIZE(firstname)) as word:chararray;
grp_data = group words by word;
final = foreach grp_data generate group,COUNT(words);
dump final;
