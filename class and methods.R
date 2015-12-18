methods(mean)
methods(plot)
methods(print)

getS3method("mean", "default")
getS3method("plot","ts")


# creat a new class , this polygon class cannot have a charater type data

library(methods)
setClass("polygon", 
         representation (x="numeric",
                           y="numeric"))
setMethod("plot","polygon",
          function(x,y,...){
                  plot(x@x,x@y, type="n",...)
                  xp <- c(x@x,x@x[1])
                  yp <- c(x@y,x@y[1])
                  lines(xp,yp)
          })

showMethods("plot")
methods(plot)


# draw a triangle by conneting the dots
p <- new("polygon", x=c(1,2,3,4,5),y=c(4,-13,-16,-8,15))
plot(p)
