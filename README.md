This repository contains the code and data for comparing iNaturalist and PlantNet identifications of plants.

Data Type: 
* Ordinal independent variable
* Binary and possibly ordinal dependent variables


Possible Statistical Techniques:
* Ordinal/Ordered Logistic Regression
* * See https://stats.oarc.ucla.edu/r/dae/ordinal-logistic-regression/
* Multinomial Logistic Regression (lose information on variable ordering)
* Ordered Probit Regression
* * See https://stats.oarc.ucla.edu/r/dae/probit-regression/
* Cumulative Link Models
* * See https://cran.r-project.org/web/packages/ordinal/vignettes/clm_article.pdf



General Formula for Analysis
result ~ variable1 + variable2 + variable3 + ... + variableN

For binary variables, these can be coded easily as 0/1 binary variables.
For variables with more than two categories, we may need to code as multiple dummy variables.

Likely need to include species as a random factor
