# first try to scrape 
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




## go through the news section IOC
url <- "https://ioc.unesco.org/news"
i <- "IOC"

# download respective archive page
page <- read_html(url) 



# pull out and trim post titles
assign(paste0("titles_",i),page %>% 
         html_nodes('.post-title a') %>% 
         html_text(trim = T))



# 
# 
# 
# ## go through the news section
# url <- "https://ioc.unesco.org/news"
# 
# 
# # download respective archive page
# page <- read_html(url) 
# 
# 
# # pull out and trim post titles
# titles <- page %>% 
#   html_nodes('.post-title a') %>% 
#   html_text(trim = T)
# titles

## go through the news section FAO
i <- "FAO"

url <- "http://www.fao.org/news/en/"

# download respective archive page
page <- read_html(url) 

# pull out and trim post titles
assign(paste0("titles_",i),page %>% 
         html_nodes('.post-title a') %>% 
         html_text(trim = T))


# download respective archive page
page <- read_html(url) 


# pull out and trim post titles
titles <- page %>% 
  html_nodes('.post-title a') %>% 
  html_text(trim = T)
titles




## and select the individual news pages to scrape the links and texts
url2 <- "https://ioc.unesco.org/news/disaster-preparedness-key-10-years-japan-quake-and-tsunami"

page2 <- read_html(url2) 

# pull out links to posts 
links <- page2 %>% 
  html_nodes('.text-align-justify a') %>% 
  html_attr("href")
links
# nice

# 
# 
# ## and select the individual news pages to scrape the links and texts
# url2 <- "https://ioc.unesco.org/news/disaster-preparedness-key-10-years-japan-quake-and-tsunami"
# 
# page2 <- read_html(url2) 
# 
# # pull out links to posts 
# links <- page2 %>% 
#   html_nodes('.text-align-justify a') %>% 
#   html_attr("href")
# links
# # nice
# 
# # text
# text <- page2 %>% 
#   html_nodes(".text-align-justify") %>% 
#   html_text(trim=T)

# text
# # don´t know where to find the text itself here. 
# 
# grepl("importance",text)
# 
# body <- list(text)
# body <- unlist(body)
# 
# 
# # create archive directory if it doesn't exist
# if(!dir.exists("io_cooperation")) dir.create("io_cooperation")
# 
# # base url
# url <- c("https://www.isa.org.jm/news/call-proposals-assessment-principal-potential-benefits-development-deep-seabed",
#          "https://www.isa.org.jm/news/isa-assembly-elects-new-council-members-period-2021-2024")
#          
# 
# 
# url <- c("https://ioc.unesco.org/news/highlights-2021-session-international-oceanographic-data-and-information-exchange-iode",
#          "https://ioc.unesco.org/news/disaster-preparedness-key-10-years-japan-quake-and-tsunami")
# 
# #i <- str_sub(url,-15)



  
