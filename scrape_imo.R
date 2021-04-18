# scrape IMO
# Arne Langlet

library(rvest)
library(tidyverse)
library(data.table)
library(httr)
library(jsonlite)
library(tidyverse)
library(stringr)

# clean environment
rm(list = ls())

source("bin_search_api_al.R")

## get url list from bing

#### IMO
out <- vector()

for (i in 1:100){
  query <- list(
    q = c("press briefings site:https://www.imo.org/en/MediaCentre/"),
    count = 50,
    offset = (i-1)*50)

  
  response <- GET(url = url,
                  add_headers('Ocp-Apim-Subscription-Key' = key),
                  query = query)
  
  
  http_type(response)
  
  headers(response)
  
  convert <- rawToChar(response$content)
  output <- fromJSON(convert)
  
  url_list <- output$webPages$value$url
  out <- c(out, url_list)
}

url_list_imo <- unique(out)


## save urls because the api calls are limited
write.csv(url_list_imo, "url_list_imo.csv")

## if you don´t want to use the bing api again, read the csv with urls

url_list_imo <- read.csv("url_list_imo.csv")
url_list_imo <- url_list_imo$x



### ------------------------------------------------------------------------ ###
##
## set user agent (NB: Important!)
## fill in correct details, uncomment, and run this line before scraping
##
httr::set_config(httr::user_agent("arne.langlet@univie.ac.at;  maripoldata.eu"))
#
### ------------------------------------------------------------------------ ###





## delete default pages
url_list_imo <- url_list_imo[!grepl("default", url_list_imo)]
url_list_imo <- url_list_imo[!grepl("Default", url_list_imo)]

# save archives and then delete from original list
url_list_imo_archives <- url_list_imo[grepl("Archives", url_list_imo)]
url_list_imo <- url_list_imo[!grepl("Archives", url_list_imo)]

# number of pages to scrape
npages <- as.integer(length(url_list_imo))

# create progress bar
pb <- txtProgressBar(min = 1, max = npages, initial = 1, char = "-", width = 60, style = 3)

#empty list for data frames
dfs <- list()
# main loop over 'npages' 

for (i in 1:npages) {
  final.url <- url_list_imo[i]
  #update progress bar
  # setTxtProgressBar(pb, i)
  
  # build file name
  file.name <- paste0("./io_cooperation/imo_page", i, "---", Sys.Date(), ".html")
  
  # avoid re-downloading by checking for files before downloading
  if (file.exists(file.name)) {
    page <- read_html(file.name)
  } else {
    tmp <- GET(final.url)
    tmp <- content(tmp, type = "text")
    write(tmp, file.name)
    page <- read_html(tmp)
  }
  # extract data
  ## for url [25]
  # titles <- page %>%
  #   html_nodes(".article-title") %>%
  #   html_text(trim = T)
  # 
  # links <- page %>%
  #   html_nodes('.content a') %>%
  #   html_attr("href")
  # 
  # texts <- page %>%
  #   html_nodes(".content") %>%
  #   html_text(trim=T)
  
  titles <- page %>%
    html_nodes(".hero-heading") %>%
    html_text(trim = T)
  
  links <- page %>%
    html_nodes('.article a') %>%
    html_attr("href")
  
  texts <- page %>%
    html_nodes(".article") %>%
    html_text(trim=T)
  
  # plow data into dataframe
  df <- data.frame(
    title = titles,
    # date = dates,
    # byline = authors,
    #  excerpt = excerpts,
    link = paste(links[grepl("http", links)], collapse = ", "),
    text = texts
  )
  
  # put page 'i' dataframe into the list
  dfs[[i]] <- df
}



# stack all page dataframes together
out <- as.data.frame(rbindlist(dfs))


# add a variable for the date of collection (R-Bloggers is updated constantly!)
out$collection_date <- Sys.Date()

out$text <- str_to_lower(out$text)

write.csv(out, file = "out_imo.csv")

