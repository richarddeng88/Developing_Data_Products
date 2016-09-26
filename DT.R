devtools::session_info('DT')


######## for more details , refer to https://rstudio.github.io/DT/  ###################
# The R package DT provides an R interface to the JavaScript library DataTables. R data objects 
# (matrices or data frames) can be displayed as tables on HTML pages, and DataTables provides filtering, 
# pagination, sorting, and many other features in the tables.
#############################################

#### 1 Usage
library(DT)
datatable(iris)

##2.1 Table CSS Classes
datatable(head(iris), class = 'cell-border stripe')

##2.2 Styling
DT:::DT2BSClass('display')
DT:::DT2BSClass(c('compact', 'cell-border'))


##2.4 Custom Column Names
datatable(head(iris), colnames = c('Here', 'Are', 'Some', 'New', 'Names'))
