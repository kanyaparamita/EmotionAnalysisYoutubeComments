library(syuzhet)

my_example_text <- "I begin this story with a neutral statement.  
  Basically this is a very silly test.  
  You are testing the Syuzhet package using short, inane sentences.  
  I am actually very happy today. 
  I have finally finished writing this package.  
  Tomorrow I will be very sad. 
  I won't have anything left to do. 
  I might get angry and decide to do something horrible.  
  I might destroy the entire package and start from scratch.  
  Then again, I might find it satisfying to have completed my first R package. 
  Honestly this use of the Fourier transformation is really quite elegant.  
  You might even say it's beautiful!"

s_v <- get_sentences(my_example_text)
s_v

syuzhet_vector <- get_sentiment(s_v, method="syuzhet")
head(syuzhet_vector)

nrc_data <- get_nrc_sentiment(s_v)

angry_items <- which(nrc_data$anger > 0)
s_v[angry_items]

joy_items <- which(nrc_data$joy > 0)
s_v[joy_items]

pander::pandoc.table(nrc_data[, 1:8], split.table = Inf)

trust_items <- which(nrc_data$trust > 0)
s_v[trust_items]

barplot(
  sort(colSums(prop.table(nrc_data[, 1:8]))), 
  horiz = TRUE, 
  cex.names = 0.7, 
  las = 1, 
  main = "Emotions in Sample text", xlab="Percentage"
)

# path_to_a_text_file <- system.file(file.path("extdata", "output.txt"), package = "utils")
path_to_a_text_file <- "/Users/kanyap/Dropbox/KANJEISTA/AKADEMIK/TU\ Delft/Courses/IN4252\ Web\ Science\ and\ Engineering/Final\ Paper/wse-finalpaper/outputtrumpcopy.txt"
youtube_comments <- get_text_as_string(path_to_a_text_file)

youtube_sv <- get_sentences(youtube_comments)

youtube_nrc <- get_nrc_sentiment(youtube_sv)

yt_angry_items <- which(youtube_nrc$anger > 0)
yt_angry_items[1:15]
youtube_sv[yt_angry_items[1:15]]

yt_sadness_items <- which(youtube_nrc$sadness > 0)
yt_sadness_items[1:15]
youtube_sv[yt_sadness_items[1:15]]

# score distribution on each category
angry_score <- youtube_nrc[1]
angry_table <- table(angry_score)
angry_table[-1]
barplot(angry_table[-1],
        main="Anger Scores Distribution",
        xlab="Scores",
        ylab="Count",
        border="red",
        col="blue",
        density=10,
        ylim=range(0,2000)
)

anticipation_score <- youtube_nrc[2]
anticipation_table <- table(anticipation_score)
anticipation_table[-1]
barplot(table(anticipation_score)[-1],
        main="Anticipation Scores Distribution",
        xlab="Scores",
        ylab="Count",
        border="red",
        col="blue",
        density=10,
        ylim=range(0,2000)
)

disgust_score <- youtube_nrc[3]
disgust_table <- table(disgust_score)
disgust_table[-1]
barplot(table(disgust_score)[-1],
        main="Digust Scores Distribution",
        xlab="Scores",
        ylab="Count",
        border="red",
        col="blue",
        density=10,
        ylim=range(0,2000)
)

fear_score <- youtube_nrc[4]
fear_table <- table(fear_score)
fear_table[-1]
barplot(table(fear_score)[-1],
        main="Fear Scores Distribution",
        xlab="Scores",
        ylab="Count",
        border="red",
        col="blue",
        density=10,
        ylim=range(0,2000)
)

joy_score <- youtube_nrc[5]
joy_table <- table(joy_score)
joy_table[-1]
barplot(table(joy_score)[-1],
        main="Joy Scores Distribution",
        xlab="Scores",
        ylab="Count",
        border="red",
        col="blue",
        density=10,
        ylim=range(0,2000)
)

sadness_score <- youtube_nrc[6]
sadness_table <- table(sadness_score)
sadness_table[-1]
barplot(table(sadness_score)[-1],
        main="Sadness Scores Distribution",
        xlab="Scores",
        ylab="Count",
        border="red",
        col="blue",
        density=10,
        ylim=range(0,2000)
)

surprise_score <- youtube_nrc[7]
surprise_table <- table(surprise_score)
surprise_table[-1]
barplot(table(surprise_score)[-1],
        main="Surprise Scores Distribution",
        xlab="Scores",
        ylab="Count",
        border="red",
        col="blue",
        density=10,
        ylim=range(0,2000)
)

trust_score <- youtube_nrc[8]
trust_table <- table(trust_score)
trust_table[-1]
barplot(table(trust_score)[-1],
        main="Trust Scores Distribution",
        xlab="Scores",
        ylab="Count",
        border="red",
        col="blue",
        density=10,
        ylim=range(0,2000)
)

colSums(prop.table(youtube_nrc[, 1:8]))
barplot(
  sort(colSums(prop.table(youtube_nrc[, 1:8]))), 
  horiz = TRUE, 
  cex.names = 0.7, 
  las = 1, 
  main = "Percentage Comparison of Emotion Sentiments",
  xlab="Percentage",
  xlim = range(0,0.25)
)
