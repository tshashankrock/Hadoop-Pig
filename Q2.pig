newrecord = LOAD '/home/shashank/Desktop/rough.txt' using PigStorage(',') as (firstname:chararray,lastname:chararray,city:chararray,gender:chararray,cgpa:double,college:chararray);
order_data = order newrecord by cgpa desc;
data_top = limit order_data 5;
dump data_top;
--pig -x local /home/shashank/Desktop/Hadoopprac/PigScript/Q2.pig;
load_tweets = LOAD '/home/shashank/Desktop/bitcoin/new.json' USING com.twitter.elephantbird.pig.load.JsonLoader('-nestedLoad') AS jsonMap;
data = foreach load_tweets generate jsonMap#'text'         As tweettext,
				    jsonMap#'retweet_count' As retweetcount,
                                    jsonMap#'metadata'      As tweetlang,
			            jsonMap#'user'         As tweetuser;
				    jsonMap#'created_at' As tweetdatatime
c = FILTER data By ((chararray)tweetlang#'iso_language_code' == 'en' );
E = FOREACH c GENERATE tweetdatatime, tweettext,retweetcount,tweetuser#'verified' AS usrverified,tweetuser#'followers_count' AS userfollower,tweetuser#'protected' AS userprotected,tweetuser#'statuses_count' AS usrstatus,tweetuser#'friends_count' AS usrfrnds,tweetuser#'favourites_count' AS userfavcount;
dump E;                     

--f = order E by desc;
store E into 'json-csvfile.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',','NO_MULTILINE','UNIX','WRITE_OUTPUT_HEADER');

