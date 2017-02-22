suppressWarnings(suppressMessages(library('tidyverse')))  # loads tons of packages
suppressWarnings(suppressMessages(library('dplyr')))
suppressWarnings(suppressMessages(library('jsonlite')))
#suppressWarnings(suppressMessages(library('rjson')))
setwd("~/Dropbox/data science/R/code")

article_key<-"&api-key=d6901a219ebe42b98d0f07b5765c1b30"
url <- "https://api.nytimes.com/svc/search/v2/articlesearch.json"
section<-"Arts"
query<-"?fq=section_name:(\"Arts\")&rank=newest&offset=%s"
req <- jsonlite::fromJSON(paste0(url,sprintf(query,0), article_key))
articles<-req$response$docs
summary(req$response$docs)
class(req$response$docs) ## !!!data.frame!!!!!
View(as.data.frame(articles))
length(articles$section_name)
  artl<-select(articles,web_url,snippet)
  artl["headline"]<-articles$headline$main
  View(artl)

req <- jsonlite::fromJSON(paste0(url,sprintf(query,1), article_key))
articles<-req$response$docs 
tempartl<-select(req$response$docs, web_url, snippet)
tempartl["headline"]<-req$response$docs$headline$main
artlnew<-bind_rows(artl,tempartl)
View(artlnew)

# 
# for(i in 0:0)
# {
#   query1<-sprintf(query,i)
#   req <- jsonlite::fromJSON(paste0(url,query1, article_key))
#   attach(req$response$docs)
#   artl<-bind_rows(artl,select(req$response$docs,web_url,headline, snippet))
#   detach(req$response$docs)
# }