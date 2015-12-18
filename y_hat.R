d <- read.csv("data/d_data_products/annual_all_2013.csv")

# subset( x, subset, select)
        # x ~ object to be subsetted
        # subset ~ logical expression indicating orws to keep. 
        # select ~ expression, indicating columns to select from a data frame. 
sub <- subset(d, Parameter.Name %in% c("PM2.5 - Local Conditions", "Ozone")
              & Pullutant.Standard %in% c("Ozone 8-Hour 2008", "PM25 Annual 2006"),
              c(Latitude,Longitude,Parameter.Name,Arithmetic.Mean))

# aggregate(x,subset,FUN)
        # x ~ an R object
        # subset ~ an optional vector specifying a subset of observations to be used.
        # FUN ~ a function to compute the summary statistics
pollave <- aggregate(sub[,"Arithmetic.Mean"], 
                     sub[,c("Longitude","Latitude","Parameter.Name")],
                     mean,na.rm=T)
names(pollave)[4] <- "level"
pollave$Parameter.Name <- factor(pollave$Parameter.Name)

rm(d,sub)

monitors <- data.matrix(pollave[, c("Longitude", "Latitude")])

library(fields)
# input is a data frame with 
        # lon ~ longitute 
        # lat ~ latitude 
        # radius in miles for finding monitors.
pollutant <- function(df){
        x <- data.matrix(df[,c("lon","lat")])
        r <- df$radius
        d <- rdist.earth(monitors,x)
        use <- lapply(seq_len(ncol(d)), function(i){
                which(d[,i] < r[i])
        })
        levels <- sapply(use, function(idx){
                with(pollave[idx,], tapply(level, Parameter.Name,mean))
        })
        dlevels <- as.data.frame(t(levels))
        data.frame(df,dlevels)
}


library(yhatr)

model.require <- function(){
        library(fields)
}

model.transform <- function(df){
        df
}

model.predict <- function(){
        pollutant(df)
}



