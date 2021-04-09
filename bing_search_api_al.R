# bing_search_api.R
# Arne Langlet

rm(list = ls())


#key <- "f6a982f746b543d79b499ba3b4e20801"


library(httr)
library(jsonlite)
library(tidyverse)


key <- "5d4735fad7904e6391ea9268a1f12a1b"

#url <- "https://api.cognitive.microsoft.com/bing/v7.0/search"

url <- "https://api.bing.microsoft.com/v7.0/search"

## I thought maybe it is the endpoint that is indicated in the my resources page
#url <- "https://api.bing.microsoft.com/"
# but it gives "resource not found"


#### UNEP
query <- list(
  q = c("story site:https://www.unep.org/news-and-stories"),
  count = 50)
# url <- "https://api.cognitive.microsoft.com"
# path <- "bing/v7.0/search"
# query <- list(
#   q = "aarhus site:dr.dk"
# )

response <- GET(url = url,
                add_headers('Ocp-Apim-Subscription-Key' = key),
                query = query)


http_type(response)

headers(response)

convert <- rawToChar(response$content)
output <- fromJSON(convert)

url_list <- output$webPages$value$url


#### IOC
query <- list(
  q = c("news site:https://ioc.unesco.org/news"),
  count = 50)
# url <- "https://api.cognitive.microsoft.com"
# path <- "bing/v7.0/search"
# query <- list(
#   q = "aarhus site:dr.dk"
# )

response <- GET(url = url,
                add_headers('Ocp-Apim-Subscription-Key' = key),
                query = query)


http_type(response)

headers(response)

convert <- rawToChar(response$content)
output <- fromJSON(convert)

url_list <- output$webPages$value$url
unique(url_list)


#### ISA
query <- list(
  q = c("news site:https://www.isa.org.jm/news"),
  count = 50)
# url <- "https://api.cognitive.microsoft.com"
# path <- "bing/v7.0/search"
# query <- list(
#   q = "aarhus site:dr.dk"
# )

response <- GET(url = url,
                add_headers('Ocp-Apim-Subscription-Key' = key),
                query = query)


http_type(response)

headers(response)

convert <- rawToChar(response$content)
output <- fromJSON(convert)

url_list <- output$webPages$value$url



#### UNEP
query <- list(
  q = c("news site:https://www.unep.org/news-and-stories/"),
  count = 50)
# url <- "https://api.cognitive.microsoft.com"
# path <- "bing/v7.0/search"
# query <- list(
#   q = "aarhus site:dr.dk"
# )

response <- GET(url = url,
                add_headers('Ocp-Apim-Subscription-Key' = key),
                query = query)


http_type(response)

headers(response)

convert <- rawToChar(response$content)
output <- fromJSON(convert)

url_list <- output$webPages$value$url

