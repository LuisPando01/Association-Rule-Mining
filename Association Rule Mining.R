#Instalar y activar paquete especial#
install.packages("arules")
library(arules)

#LEER EL DATASET#
groceries <- read.transactions("groceries.csv",sep = ",")
summary(groceries)

#Cómo se ve la tabla#
image(groceries[1:5])
image(sample(groceries, 100))
itemFrequency(groceries[, 5:6])

#Plots#
itemFrequencyPlot(groceries, support = 0.1)
itemFrequencyPlot(groceries, topN = 20)
inspect(groceries[1:5])

###CREATE THE MODEL###
apriori(groceries)
#No rules were generated

#Try with some parameters
groceryrules <- apriori(groceries, parameter = 
                          list(support = 0.006, confidence = 0.25, minlen = 2))
#463 rules were created
#Try and error with the parameters until the result is around 10 rules would be an option

#Too many rules, check them
summary(groceryrules)

#Inspect some rules, to see if they are useful
inspect(groceryrules[1:3])
#The first makes no sense in real life

#Sort the rules by lift
inspect(sort(groceryrules, by = "lift")[1:5])
#This rules make much more sense

#Take a subset of rules
berryrules <- subset(groceryrules, items %in% "berries")
inspect(berryrules)
#Check the rules