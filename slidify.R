library(devtools)
#install_github("slidify","ramnathv")
#install_github("slidifyLibraries","ramnathv")
library(slidify)

# set the working directory into where you want to create your slidify project
# sedwd()

author("first try")

slidify("index.Rmd")
browseURL("index.html")
