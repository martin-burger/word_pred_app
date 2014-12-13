


## Load Packages

library(RCurl)
library(tm)

## Load Data

load("tt.rdata")
setkey(tt,n_1)

## Load Test data

test.text <- getURLContent("http://www.gutenberg.org/cache/epub/47448/pg47448.txt")
writeLines(test.text,"test.txt")

data_file <- file("test.txt", "rb",encoding="UTF-8")

data <- readLines(data_file)

# Funktionen definieren

cleanData <- function(data) {
  library(tm)
  data <- tolower(data) # convert to lowercase
  data <- removeNumbers(data) # remove numbers
  punctuation <- '[.,!:;?]|:-\\)|:-\\(|:\\)|:\\(|:D|=D|8\\)|:\\*|=\\*|:x|:X|:o|:O|:~\\(|T\\.T|Y\\.Y|S2|<3|:B|=B|=3|:3'
  data <- gsub(punctuation," END ",data) # substitute selected ponctuation (including smileys) with the word END
  # data <- gsub("$"," END",data) # make sure every line ends with an END
  data <- gsub("\\b(\\w+)\\s+\\1\\b","\\1",data) # remove duplicate words in sequence (eg. that that)
  data <- gsub("\\b(\\w+)\\s+\\1\\b","\\1",data) # remove duplicate words in sequence (eg. that that)
  data <- gsub("\\b(\\w+)\\s+\\1\\b","\\1",data) # remove duplicate words in sequence (eg. that that)
  data <- removePunctuation(data) # remove all other punctuation
  data <- stripWhitespace(data) # remove excess white space
  data <- gsub("^[[:space:]]","",data) # make sure lines doesn't begin with space
  data <- gsub("[[:space:]]$","",data) # make sure lines doesn't end with space
}

predict_test <- function(input) {
  
  ret_val <- head(tt[n_1==input,n,prob][order(-prob)],1)
  return(ret_val[1,n])
  
}

testAccuracy <- function(words){
  word.count=length(words)-11
  correct <- 0
  predictions <- 0
  for (i in 1:word.count) {
    #  print(paste("word:",i,"/",word.count))
    for (j in 0:1) {
      
      ngram <- paste(words[i:(i+j)],collapse =" ")
      
      if (grepl("END", ngram) != TRUE && grepl("END", words[i+j+1]) != TRUE)  {
      
        predicted <- predict_test(ngram)
        
        predictions <- predictions + 1
        
        if(is.na(predicted)[1]) {predicted <- "the"}
        
        print(paste("input:",ngram, " ","predicted:", predicted, " ","real:",words[i+j+1]))
        
        
        if (predicted == words[i+j+1]) {
          correct <- correct + 1
          print(paste("Succes: ",correct / predictions * 100))
        }     
      
      }
    }
    
  }
  
  print(paste("Succes: ",correct / predictions * 100))
  
}

# letzten Vorbereitungsschritte

data_clean <- cleanData(data)
data_test <- unlist(str_split(data_clean,"\\W+"))
data_test <- data_test[data_test != ""]

# Test

testAccuracy(data_test[1:200])






