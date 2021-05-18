# Library in packages used in this application
library(shiny)
library(DT)
library(DBI)
library(RSQLite)
library(shinyjs)
library(shinycssloaders)
library(lubridate)
library(shinyFeedback)
library(dplyr)
library(dbplyr)
library(tidyverse)
library(shinymanager)


# vc_tbl <- readRDS("data/emptymtcars.RDS")
# vc_tbl <- vc_tbl %>% select(-(1:nrow(.)))
# readRDS("../testtask/data_prep/prepped/emptymtcars.RDS") %>%
#   mutate(uid = 1) %>%
#   mutate(created_at = 1) %>%
#   mutate(created_by = 1) %>%
#   mutate(modified_at = 1) %>%
#   mutate(modified_by = 1)
  
inactivity <- "function idleTimer() {
var t = setTimeout(logout, 120000);
window.onmousemove = resetTimer; // catches mouse movements
window.onmousedown = resetTimer; // catches mouse movements
window.onclick = resetTimer;     // catches mouse clicks
window.onscroll = resetTimer;    // catches scrolling
window.onkeypress = resetTimer;  //catches keyboard actions

function logout() {
window.close();  //close the window
}

function resetTimer() {
clearTimeout(t);
t = setTimeout(logout, 120000);  // time is in milliseconds (1000 is 1 second)
}
}
idleTimer();"


# define some credentials
credentials <- data.frame(
  user = c("admin", "user"), # mandatory
  password = c("admin", "user"), # mandatory
  expire = c(NA, NA),
  admin = c(TRUE, FALSE),
  stringsAsFactors = FALSE
)

db_config <- config::get()$db

# Create connection object with Postgreas
# conn <- dbConnect(
#   RPostgres::Postgres(),
#   dbname = db_config$dbname, 
#   port = 5432 # change to your port to connect
# )


# Create database connection
conn <- dbConnect(
  RSQLite::SQLite(),
  dbname = db_config$dbname
)

# Stop database connection when application stops
shiny::onStop(function() {
  dbDisconnect(conn)
})



# Turn off scientific notation
options(scipen = 999)

# Set spinner type (for loading)
options(spinner.type = 8)
