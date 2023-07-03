> library(syuzhet)
> my_example_text <- "I begin this story with a neutral statement.  
+   Basically this is a very silly test.  
+   You are testing the Syuzhet package using short, inane sentences.  
+   I am actually very happy today. 
+   I have finally finished writing this package.  
+   Tomorrow I will be very sad. 
+   I won't have anything left to do. 
+   I might get angry and decide to do something horrible.  
+   I might destroy the entire package and start from scratch.  
+   Then again, I might find it satisfying to have completed my first R package. 
+   Honestly this use of the Fourier transformation is really quite elegant.  
+   You might even say it's beautiful!"
> s_v <- get_sentences(my_example_text)
> class(s_v)
[1] "character"
> str(s_v)
chr [1:12] "I begin this story with a neutral statement." ...
> head(s_)
Error in head(s_) : object 's_' not found
> head(s_v)
[1] "I begin this story with a neutral statement."                     
[2] "Basically this is a very silly test."                             
[3] "You are testing the Syuzhet package using short, inane sentences."
[4] "I am actually very happy today."                                  
[5] "I have finally finished writing this package."                    
[6] "Tomorrow I will be very sad."                                     
path_to_a_text_file <- system.file("extdata", "/Users/kanyap/Dropbox/KANJEISTA/AKADEMIK/TU\ Delft/Courses/IN4252\ Web\ Science\ and\ Engineering/Final\ Paper/Syuzhet/4217-0.txt", package = "syuzhet")
joyces_portrait <- get_text_as_string(path_to_a_text_file)
Warning message:
  In file(con, "r") :
  file("") only supports open = "w+" and open = "w+b": using the former
> path_to_a_text_file <- system.file("extdata", "portrait.txt",package = "syuzhet")
> joyces_portrait <- get_text_as_string(path_to_a_text_file)
> poa_word_v <- get_tokens(joyces_portrait, pattern = "\\W")
> syuzher_vector <- get_sentiment(poa_word_v, method="syuzhet")
> head(syuzher_vector)
[1] 0.0 0.0 0.0 0.0 0.6 0.0
> sum(syuzher_vector)
[1] -170.15