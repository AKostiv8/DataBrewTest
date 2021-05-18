library(RSQLite)
library(tibble)
# library(DBI)
# library(tidyverse)

# Create connection object with Postgreas
# con_postrgres <- dbConnect(
#   RPostgres::Postgres(),
#   dbname = "databrew_test", 
#   port = 5432 # change to your port to connect
# )


# Create a connection object with SQLite
conn <- dbConnect(
  RSQLite::SQLite(),
  "../testtask/shiny_app/data/mtcars.sqlite3"
)

# Create a query to prepare the 'mtcars' table with additional 'uid', 'id',
# & the 4 created/modified columns
create_mtcars_query = "CREATE TABLE mtcars (
  uid                             TEXT PRIMARY KEY,
  model                           TEXT,
  mpg                             REAL,
  cyl                             REAL,
  disp                            REAL,
  hp                              REAL,
  drat                            REAL,
  wt                              REAL,
  qsec                            REAL,
  vs                              TEXT,
  am                              TEXT,
  gear                            REAL,
  carb                            REAL,
  created_at                      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by                      TEXT,
  modified_at                     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_by                     TEXT
)"

create_mtcars_vc_query = "CREATE TABLE mtcars_vc (
  uid                             TEXT PRIMARY KEY,
  status                          TEXT,
  model                           TEXT,
  mpg                             REAL,
  cyl                             REAL,
  disp                            REAL,
  hp                              REAL,
  drat                            REAL,
  wt                              REAL,
  qsec                            REAL,
  vs                              TEXT,
  am                              TEXT,
  gear                            REAL,
  carb                            REAL,
  created_at                      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by                      TEXT,
  modified_at                     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_by                     TEXT
)"


# dbExecute() executes a SQL statement with a connection object
# Drop the table if it already exists
dbExecute(conn, "DROP TABLE IF EXISTS mtcars")
dbExecute(conn, "DROP TABLE IF EXISTS mtcars_vc")
# Execute the query created above
dbExecute(conn, create_mtcars_query)
dbExecute(conn, create_mtcars_vc_query)

# Read in the RDS file created in 'data_prep.R'
dat <- readRDS("../testtask/data_prep/prepped/mtcars.RDS")

# add uid column to the `dat` data frame
dat$uid <- uuid::UUIDgenerate(n = nrow(dat))

# reorder the columns
dat <- dat %>%
  select(uid, everything())

# Fill in the SQLite table with the values from the RDS file
DBI::dbWriteTable(
  conn,
  name = "mtcars",
  value = dat,
  overwrite = FALSE,
  append = TRUE
)

# DBI::dbWriteTable(
#   conn,
#   name = "mtcars_vc",
#   value = dat[1, ],
#   overwrite = FALSE,
#   append = TRUE
# )

# dbExecute(conn, "SELECT * FROM mtcars")

# List tables to confirm 'mtcars' table exists
dbListTables(conn)

# DBI::dbWriteTable(
#   conn,
#   name = "mtcars_vc",
#   value = dat[1, ],
#   overwrite = FALSE,
#   append = TRUE
# )


# disconnect from SQLite before continuing
dbDisconnect(conn)
