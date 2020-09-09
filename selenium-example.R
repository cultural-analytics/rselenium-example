############################################################################################################
# Tutorial example based on RSelenium docs: https://cran.r-project.org/web/packages/RSelenium/RSelenium.pdf
# The following tutorials may also be useful to your projects:
#  http://joshuamccrain.com/tutorials/web_scraping_R_selenium.html
#  https://www.rpubs.com/widai/scraping_data_with_RSelenium
############################################################################################################

library(tidyverse)
library(rvest)
library(RSelenium)
library(robotstxt)

driver <- rsDriver(browser=c("chrome"), chromever="85.0.4183.83")
remote_driver <- driver[["client"]]
remote_driver$open()

remote_driver$navigate("https://www.thingiverse.com/")

scrape.list <- remote_driver$findElements(using = 'class name', value = 'ThingCardBody__cardBodyWrapper--ba5pu')

scrape.urls <- vector()

for (i in seq_along(scrape.list)) {
  url.add <- scrape.list[[i]]$getElementAttribute("href")
  scrape.urls <- c(scrape.urls, url.add)
}

scrape.urls

#####################################################
# Accessing robots.txt and delaying scraping scripts
#####################################################

r_text <- get_robotstxt("https://www.thingiverse.com/")
r_text <- parse_robotstxt(r_text)
r_text

# Show the amount of delay
r_text$crawl_delay$value

# Delays for the amount of seconds given
Sys.sleep(3)
