# scrape UNEP
# Arne Langlet

library(rvest)
library(tidyverse)
library(data.table)
library(httr)

### ------------------------------------------------------------------------ ###
##
## set user agent (NB: Important!)
## fill in correct details, uncomment, and run this line before scraping
##
httr::set_config(httr::user_agent("arne.langlet@univie.ac.at;  maripoldata.eu"))
#
### ------------------------------------------------------------------------ ###


url_list <- url_list[-25]

# number of pages to scrape
npages <- as.integer(length(url_list))

# create progress bar
pb <- txtProgressBar(min = 1, max = npages, initial = 1, char = "-", width = 60, style = 3)

#empty list for data frames
dfs <- list()
# main loop over 'npages' 

for (i in 1:npages) {
  final.url <- url_list[i]
  #update progress bar
  # setTxtProgressBar(pb, i)
  
  # build file name
  file.name <- paste0("./io_cooperation/unep_page", i, "---", Sys.Date(), ".html")
  
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
  #   html_nodes(".font-bold") %>% 
  #   html_text(trim = T)
  # 
  # links <- page %>% 
  #   html_nodes('.max-w-8xl a') %>% 
  #   html_attr("href")
  # 
  # texts <- page %>% 
  #   html_nodes(".max-w-8xl") %>% 
  #   html_text(trim=T)
  
  titles <- page %>%
    html_nodes(".article_header_meta_wrap") %>%
    html_text(trim = T)

  links <- page %>%
    html_nodes('.content_wrap a') %>%
    html_attr("href")

  texts <- page %>%
    html_nodes(".content_wrap") %>%
    html_text(trim=T)
  
  # plow data into dataframe
  df <- data.frame(
    title = titles,
    # date = dates,
    # byline = authors,
    #  excerpt = excerpts,
    link = paste(links[grepl("https", links)], collapse = ", "),
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

write.csv(out, file = "out_unep.csv")

