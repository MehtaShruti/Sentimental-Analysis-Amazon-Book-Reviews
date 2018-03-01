#Web scraping

#install.packages("rvest")
library(rvest)

#Dataframe to store reviews
review=data.frame(ReviewContent=character(),stringsAsFactors=FALSE)

for(i in 1:500)#Pagenation through 500 pages for 5000 reviews
{
  url=paste("https://www.amazon.com/Girl-Train-Paula-Hawkins/product-reviews/1594634025/ref=cm_cr_getr_d_paging_btm_",i,"?ie=UTF8&reviewerType=avp_only_reviews&sortBy=helpful&pageNumber=",i,sep="")
  review_data <- read_html(url)
  
  text <- review_data %>% 
    html_nodes("#cm_cr-review_list .review .review-data .review-text") %>%
    html_text() 
  
  for(j in 1:length(text))
    {
       review[nrow(review)+1,] <- c(text[j])
    }
}

#Writing to csv
write.csv(review,file = "F:/INFO7390-ADS/Final_Project/Reviews.csv",row.names = FALSE)

