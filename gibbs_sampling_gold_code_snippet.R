library(dplyr)
library(dlm)
library(plotly)

fpath <- ''
df <- read.csv(fpath)
y <- c()

model <- dlmModPoly(order = 3)
gibbs <- dlmGibbsDIG(y, model,
                     shape.y=10, rate.y=100,
                     shape.theta = 10, rate.theta = 100,
                     n.sample=1000, save.states = F)
burn.period <- 100
posteriors <- mcmcMean(gibbs$dV[-(1:burn.period)],
                       gibbs$dW[-(1:burn.period),])

model <- dlmModPoly(order = 3,
                    dV = posteriors[1,1],
                    dW = posteriors[1, 2:4])
model <- dlmFilter(y, model)