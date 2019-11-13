options("repos"="http://cran.rstudio.com") # set the cran mirror

packages = c("devtools",
"dplyr",
"ggmap",
"ggplot2",
"grid",
"gridExtra",
"knitr",
"latticeExtra",
"markdown",
"NLP",
"parallel",
"plyr",
"png",
"raster",
"rCharts",
"RCurl",
"rgdal",
"rgeos",
"RJDBC",
"RJSONIO",
"RMySQL",
"rstudio",
"shiny",
"sp",
"stringr",
"tidyr",
"tinytex",
"tm",
"wordcloud",
"XLConnect",
"xts")

packages = setdiff(packages, installed.packages()[,"Package"])
if (length(packages) != 0){
  (install.packages(packages, dep=c("Depends", "Imports")))
}

# Packages from github are installed unconditionally
ghpackages = c("rstudio/htmltools","trestletech/shinyTable","rstudio/rmarkdown","rstudio/shiny")
devtools::install_github(ghpackages)
update.packages(ask=FALSE)
