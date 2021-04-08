# scrape UNEP
# Arne Langlet

library(rvest)
library(tidyverse)
library(data.table)

### ------------------------------------------------------------------------ ###
##
## set user agent (NB: Important!)
## fill in correct details, uncomment, and run this line before scraping
##
httr::set_config(httr::user_agent("arne.langlet@univie.ac.at;  maripoldata.eu"))
#
### ------------------------------------------------------------------------ ###

length(url_list)
url_list
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
  file.name <- paste0("./io_cooperation/isa_page", i, "---", Sys.Date(), ".html")
  
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
  titles <- page %>%
    html_nodes(".page-title") %>%
    html_text(trim = T)
  
  links <- page %>% 
    html_nodes('.field a') %>% 
    html_attr("href")
  
  texts <- page %>% 
    html_nodes(".field__item") %>% 
    html_text(trim=T)
  
  # metadata <- page %>%
  #   html_nodes(".meta") %>%
  #   html_text(trim = T) %>%
  #   str_replace('\\|', '-splithere-') %>%
  #   str_split('-splithere-') %>%
  #   map(str_trim)
  # # 
  # dates <- metadata %>%
  #   map_chr(1)
  # 
  # authors <- metadata %>% 
  #   map_chr(2)
  # 
  # excerpts <- page %>% 
  #   html_nodes(".mh-excerpt") %>%
  #   html_text(trim = T)
  
  # plow data into dataframe
  df <- data.frame(
    title = titles,
    # date = dates,
    # byline = authors,
    #  excerpt = excerpts,
    link = paste(links[grepl("https", links)], collapse = ", "),
    text = texts[5]
  )
  
  # put page 'i' dataframe into the list
  dfs[[i]] <- df
}


# stack all page dataframes together
out <- as.data.frame(rbindlist(dfs))


# add a variable for the date of collection (R-Bloggers is updated constantly!)
out$collection_date <- Sys.Date()

out$text <- str_to_lower(out$text)

out$text
write.csv(out, file = "out_isa.csv")

