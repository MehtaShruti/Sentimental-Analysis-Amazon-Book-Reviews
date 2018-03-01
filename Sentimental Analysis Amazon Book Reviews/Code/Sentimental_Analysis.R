library(tm)
library(NLP)
#install.packages("qdap")
library(qdap)
library(stringr)

setwd("F:/INFO7390-ADS/Final_Project")

#Positive Lexicons

positive_lexicons <- read.csv(file="positive-words.csv", header=TRUE, sep= ',')
positive_lexicons <- Corpus(VectorSource(positive_lexicons)) #Converting to corpus
positive_lexicons <- tm_map(positive_lexicons,stemDocument) #Stemming
positive_lexicons <- data.frame(text=sapply(positive_lexicons, `[[`, "content"), stringsAsFactors=FALSE) #Converting to dataframe
positive_lexicons <- unique(positive_lexicons) #Fetching only unique positive words
positive_lexicons<-data.frame(Words=unlist(positive_lexicons)) #Unlisting

#Negative Lexicons

negative_lexicons <- read.csv(file="negative-words.csv", header=TRUE, sep= ',')
negative_lexicons <- Corpus(VectorSource(negative_lexicons)) #Converting to corpus
negative_lexicons <- tm_map(negative_lexicons,stemDocument) #Stemming
negative_lexicons <- data.frame(text=sapply(negative_lexicons, `[[`, "content"), stringsAsFactors=FALSE) #Converting to dataframe
negative_lexicons <- unique(negative_lexicons) #Fetching only unique positive words
negative_lexicons<-data.frame(Words=unlist(negative_lexicons)) #Unlisting

#Result Dataframe to store review,sentimental score
df <- data.frame("Review"=character(),"Positive Word Count"=integer(),"Negative Word Count"=integer(),"Total Word Count"=integer(),"Positivity Percentage"=integer(),"Negativity Percentage"=integer(),"Result"=character(),stringsAsFactors = FALSE)

#Review Data
review <- read.csv(file="Reviews.csv", header=TRUE, sep= ',')
NROW(review) #Number of rows of dataframe 'review'

for(k in 1:NROW(review))
{

review_data=review[k,]  #To extract data from each row and all columns
review_original<-review_data

df[nrow(df)+1,1]<-c(toString(review_original))

review_data = tolower(review_data) #Making it lower case
review_data = gsub('[[:punct:]]', '', review_data) #Removing  punctuation
review_data = gsub("[[:digit:]]", "", review_data) #Removing numbers
review_data <- Corpus(VectorSource(review_data)) #Converting into corpus
review_data = tm_map(review_data, removeWords, stopwords('english'))  #Removing stop words
review_data=tm_map(review_data,stemDocument) #Stemming 
#strwrap(b[[1]]) #To view the stemmed data

review_data <- data.frame(text=sapply(review_data, `[[`, "content"), stringsAsFactors=FALSE)#Converting corpus to dataframe
#review_data
#typeof(review_data)

review_data<-str_trim(clean(review_data)) #To remove extra white spaces 
review_data<- as.String(review_data)
review_words <- strsplit(review_data, " ") #Splitting a sentence into words
length(review_words)
review_words<-data.frame(Words=unlist(review_words)) #Unlisting 

review_words<-as.matrix(review_words,nrow=NROW(review_words),ncol=NCOL(review_words)) #Matrix
NROW(review_words)

positive_count=0
negative_count=0
total_word_count=NROW(review_words)

for(i in 1:NROW(review_words)) #Each word of that review
{
  if(review_words[i][1] %in% positive_lexicons$Words)
    positive_count=positive_count+1
  else if (review_words[i][1] %in% negative_lexicons$Words)
    negative_count=negative_count+1
}

positive_count
negative_count
total_word_count
positivity_percentage=(positive_count/total_word_count)*100
negativity_percentage=(negative_count/total_word_count)*100
result=""

if(positivity_percentage>negativity_percentage)
{result='Positive'
}else
{result='Negative'}

result

df[nrow(df),2:7]<- c(positive_count,negative_count,total_word_count,positivity_percentage,negativity_percentage,result)
#df
}

#Writing to csv
write.csv(df,"Sentimental_Analysis_Result.csv")
