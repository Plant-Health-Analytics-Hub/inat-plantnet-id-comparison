# DATA PROCESSING SCRIPT
source("./R/loadPackages.R")

# Load data
collectedData <- readxl::read_excel("./data/GB AI Project - Data long format.xlsx",
                                    sheet = "Collected plants")
colnames(collectedData)
collectedData_toolLocationTime <- pivot_longer(collectedData,
                                              cols = c(colnames(collectedData)[5:13]),
                                              values_to = "assessment")
collectedData_toolLocationTime <- separate(collectedData_toolLocationTime,
                                           col = "name", 
                                           into = c("toolType", "location", "year"),
                                           sep = " ")

collectedData_toolLocationTime |> group_by(toolType, location, year) |> 
  ggplot(aes(x = toolType,
             y = assessment,
             fill = year)) +
  geom_violin() +
  facet_wrap(location ~ .)

# Assessment is an ordered factor, apply appropriate data transform
collectedData_toolLocationTime$assessment <- factor(collectedData_toolLocationTime$assessment,
                                                    levels = c(0:3),
                                                    labels = c("0", "1", "2", "3"),
                                                    ordered = TRUE)

# for THESE comparisons, we should use latest year data and no location
currentYearNL <- collectedData_toolLocationTime[collectedData_toolLocationTime$year == "23" &
                                                  collectedData_toolLocationTime$location == "NL",]

# best approach is a cumulative linked mixed model with a logit transform
# allows random effects (e.g. Lab ID) which improves model performance
model2 <- clmm(assessment ~ toolType + Family + Status + (1|`Lab ID`), data = collectedData_toolLocationTime,
               Hess = TRUE, nAGQ = 7)
model2

# calculate 1-tailed p-values for z scores
pnorm(coef(summary(model2))[, "z value"], lower.tail = FALSE)[-1:-3]
coef(summary(model2))[, c(1,3)]

statsTable <- cbind(coef(summary(model2))[, c(1,3)], pnorm(coef(summary(model2))[, "z value"], lower.tail = FALSE))
colnames(statsTable)[3] <- "Pr > Z || Pr < Z"
statsTable
