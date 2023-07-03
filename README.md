# Emotion Analysis Youtube Comments

This project aim to automatically analyse viewer's emotion from watching a Youtube video. In this case, we are using President Donald Trump’s State Of The Union Address 2018 Youtube video ([link](https://www.youtube.com/watch?v=exsOim0Lyl4)).

## Background

The State of the Union Address (SOTU) is the President of the United States' communication to Congress, covering the nation's current condition, policy proposals, and priorities for the upcoming legislative year. The 2016 presidential election resulted in Donald J. Trump's victory despite losing the popular vote, which was a surprising political event. Trump's first State of the Union Address in 2018 received significant viewership and social media interactions, making it an interesting source for analyzing public opinion. YouTube comments, along with Twitter posts, provide sentiment expression on various global issues, including politics. These comments reflect viewers' opinions on video content quality, relevance, and popularity. Sentiment analysis, specifically emotion analysis, helps evaluate public opinions and attitudes towards entities, individuals, issues, events, and topics. This paper focuses on analyzing viewer opinions and public response to Trump's Address using YouTube comments as a representation of global sentiment.

## Approach

Sentiment analysis techniques, including lexicon-based and machine learning approaches, are used to analyze emotions in text data. This paper focuses on a lexicon-based approach to perform emotion analysis on YouTube comments. Opinion words are used to count and categorize sentiment, with the sentence assigned to the sentiment category with the highest count of opinion words. Despite some limitations, this method is simple, efficient, and provides reasonable results. The Syuzhet Package in R programming language ([link](http://cran.r-project.org/web/packages/syuzhet/)) is used for its practical implementation, variety of sentiment analysis features, and rich lexicon of opinion words. The package provides numeric scores for different emotion categories based on word matches and sentiment intensity. It can be applied at various levels, such as single sentences, paragraphs, or topics. Syuzhet offers four lexicon collections, including nrc with eight additional emotion-based categories (• anger, anticipation, disgust, fear, joy, sadness, surprise, and trust). The score for each sentence is determined by counting the occurrence of words in the respective categories. The resulting scores differ across sentiment categories, representing negative to positive sentiment.

### Data Collection Process
The YouTube Data API V3 5 ([link](https://developers.google.com/youtube/v3)), provided by Google Console as on of their product feature, is used to collect comments on the YouTube video titled "President Donald Trump’s State Of The Union Address 2018 (Full) | NBCNews". YouTube Data API allows us to search for videos data matching specific search criteria in a save https connection using API credentials that is unique to each of our Google account to ensure more security. Through this process we collected 5,162 comments towards the video.

### Sentimen Analysis Process
The collected YouTube comments are pre-processed first to remove unnecessary comments that does not have any meaning. The Syuzhet Package is used implemented in the analyzing process of the emotion sentiment scores for the comments. Each comment was analyzed as a single sentences and not as a whole text. Thus, each of the comment will have its own sentiment score. For example an example comment "Time to quit listening to their coercive attempts to keep us fearing and hating each other" resulting a sentiment scoring as shown in table below.

| Emotion      | Sentiment Category |
|--------------|--------------------|
| Anger        |         1          |
| Anticipation |         1          |
| Disgust      |         0          |
| Fear         |         1          |
| Joy          |         0          |
| Sadness      |         0          |
| Surprise     |         0          |
| Trust        |         0          |

## Results

| Category     | 1    | 2    | 3   | 4  | 5 | 6 | 7 | 8 |
|--------------|------|------|-----|----|---|---|---|---|
| Anger        | 1063 | 174  | 20  | 6  | 2 | 1 | | |
| Anticipation | 1299 | 299  | 62  | 8  | 2 | | | |
| Disgust      | 943  | 123  | 18  | 4  | | 2 | | |
| Fear         | 1195 | 191  | 29  | 11 | 4 | | | |
| Joy          | 1216 | 282  | 52  | 9  | 1 | 3 | | |
| Sadness      | 1152 | 173  | 23  | 4  | 2 | | | |
| Surprise     | 1274 | 186  | 20  | 2  | | | | |
| Trust        | 1629 | 506  | 158 | 38 | 7 | 5 | 3 | 1 |

The sentiment analysis result can be seen in table above as a summary of frequency counts for each score values in the range and for all emotion sentiment categories.

![Sentiment scores distribution for all emotion sentiment categories](/plots/sentiment_score_dist.png)

Figure above shows the comparison of these frequency distribution across the different categories. Looking at this distribution, it can be seen that emotion trust has relatively higher variance as the number of object that has trust score above or equal to 2 is more than 500. This means there are high amount of comments of the video expressing great sense of trust after the comment’s creator watch the video.

| Emotion Sentiment Category | Percentage Value |
|--------------|--------------------|
| Anger        |         0.09877108 | 
| Anticipation |         0.13890705 | 
| Disgust      |         0.08308276 | 
| Fear         |         0.11295594 | 
| Joy          |         0.13040920 | 
| Sadness      |         0.10413126 | 
| Surprise     |         0.11204079 | 
| Trust        |         0.21970192 |

![Percentage comparison of sum of sentiment scores for all emotion sentiment categories](/plots/sentiment_comp_pct.png)

Table above and figure above show the summary of which emotions dominates the comment section of the video. Top 3 emotion categories that have highest percentage are trust, anticipation and joy with percentage value 0.22, 0.14 and 0.13 respectively. While disgust and anger sits at the bottom 2 position with percentage value 0.08 and 0.09 respectively.

Based on the results, 3 most dominant emotions reflected from the "President Donald Trump’s State Of The Union Address 2018" YouTube video’s comment section are filled with rather positive emotions. While anticipation is a neutral emotion that can both express hope and anxiety, trust and joy are forms of positive emotions. All the emotions that perceived negatively such as fear, sadness, anger, and disgust all have approximately 0.10 to 0.20 percentage value difference with trust as the dominating emotion.

## Conclusion

Looking only from this sentiment analysis results, we can gain an insight that some people are developing sense of trust for Trump over his speech at the Address on 2018. This could be because of some mentioned achievement in the speech such as how the African-American and Hispanic-American unemployment rate in his period was at the lowest rate ever recorded. His mention over how the stock market has been done well could also contribute to the developing of trust amongst the viewer of his speech. People were also developing anticipating emotion as a sense of hope for what Trump can bring in the upcoming years of his presidential period but can also be that people are cautiously looking over him to see if he is fulfilling what he said on the speech. This development of sense might be supported by his mentions about the nation plan for the upcoming years such as immigration reform plan on offering path to citizenship for illegal immigrants, reducing the price of prescription drugs, and investing more on infrastructure to fix the infrastructure deficit of the country. While some of the negative emotions implied on the comments could come from several facts Trump mentioned in his message that a lot of people believed need to be fact checked.

Although these sentiment analysis results give a pleasant insight on the emotional response towards Trump’s first Address after he got elected as president but it should not be taken as a full representation of how the nation feel towards it. Such factors that need to be considered about the results are that generally the samples are limited to people that has YouTube account and the comment creator may not a U.S. citizen as such information is not available.