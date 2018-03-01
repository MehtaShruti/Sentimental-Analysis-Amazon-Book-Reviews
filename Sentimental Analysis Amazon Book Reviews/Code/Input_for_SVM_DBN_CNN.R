setwd("F:/INFO7390-ADS/Final_Project")
data <- read.csv(file="Reviews.csv", header=TRUE, sep= ',')

#Converting dataframe to corpus
mycorpus <- Corpus(DataframeSource(data))
mycorpus

#Preparing the corpus
getTransformations()

#To create a custom transformation we make use of content transformer() t
#toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
#mycorpus <- tm_map(mycorpus, toSpace, "/|@|\\|")

# Conversion to Lower Case
mycorpus <- tm_map(mycorpus, content_transformer(tolower))

#Remove Numbers
mycorpus <- tm_map(mycorpus, removeNumbers)

#Remove Punctuation
mycorpus <- tm_map(mycorpus, removePunctuation)

#Remove English Stop Words
mycorpus <- tm_map(mycorpus, removeWords, stopwords("english"))
mycorpus <- tm_map(mycorpus, removeWords, c("hmmmm", "can", "say", "im", "your", "get", "asap","let", "ok","ugh"))

#Strip Whitespace
mycorpus <- tm_map(mycorpus, stripWhitespace)

#Stemming
mycorpus <- tm_map(mycorpus, stemDocument)

#Creating a Document Term Matrix
dtm <- DocumentTermMatrix(mycorpus)
dim(dtm) #Dimension

#Converting document term matrix to dataframe
df <- as.data.frame(as.matrix(dtm),row.names = FALSE)

#Writing to csv
write.csv(df,"F:/INFO7390-ADS/Final_Project/Input.csv")
