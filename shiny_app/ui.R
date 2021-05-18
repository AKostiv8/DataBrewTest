fluidPage(
  shinyFeedback::useShinyFeedback(),
  shinyjs::useShinyjs(),
  tags$head(
    tags$link(rel="icon", href="https://img.icons8.com/ios/452/big-data.png"),
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
    tags$script(src = "scriptC.js"),
    tags$script(src = "https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js")
  ),
  
  # authentication module
  auth_ui(
    id = "auth",
    # add image on top ?
    tags_top =
      tags$div(
        tags$h4("Test Task", style = "align:center"),
        tags$img(
          src = "https://pbs.twimg.com/profile_images/863857764669325312/kGivy491_400x400.jpg", width = 100
        )
      ),
    # change auth ui background ?
    # https://developer.mozilla.org/fr/docs/Web/CSS/background
    background  = "#b97800",
    choose_language = FALSE
  ),
  

  # Application Title
  
  titlePanel(
    h1("R/Shiny Test Task", align = 'center'),
    windowTitle = "Data Brew Test"
  ),
  cars_table_module_ui("cars_table")
  # textOutput("test_text"),
  # tableOutput("delCar")
)



