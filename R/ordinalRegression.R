#####
# Ordinal/Ordered Regression
#####
# follow the approach here:
# https://stats.oarc.ucla.edu/r/dae/ordinal-logistic-regression/
  
source("./R/loadPackages.R") # load packages

# for ordinal regression, use MASS::polr()
# for formula, use the form:
# responseVariable ~ variable1 + variable2 + ... + variableN
# for interactions between two variables, use a * instead of +