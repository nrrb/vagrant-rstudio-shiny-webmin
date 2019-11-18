options("repos"="http://cran.rstudio.com") # set the cran mirror

base_packages = c("base64enc",
"devtools",
"dplyr",
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
"rmarkdown",
"rstudio",
"shiny",
"sp",
"stringr",
"tidyr",
"tinytex",
"tm",
"wordcloud",
"xts")

# Add packages required in fzettelmeyer's mktg482_R_installation.Rmd file
fz_packages = c('rmarkdown', 'gmodels', 'modelr', 'janitor', 'haven', 'readxl', 
                'knitr', 'psych', 'statar', 'tidyverse', 'devtools', 'lfe', 'Matrix')
packages = c(base_packages, fz_packages)


packages = setdiff(packages, installed.packages()[,"Package"])
if (length(packages) != 0){
  (install.packages(packages, dep=c("Depends", "Imports")))
}

# Packages from github are installed unconditionally
ghpackages = c("rstudio/htmltools","trestletech/shinyTable")
devtools::install_github(ghpackages)
# Other tools used in fzettelmeyer's MKTG-482 class
devtools::install_github("fzettelmeyer/mktg482", upgrade = "never", force = TRUE)
update.packages(ask=FALSE)
