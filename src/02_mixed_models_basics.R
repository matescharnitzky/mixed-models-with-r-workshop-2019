
# 1. packages -------------------------------------
library(tidyverse)
library(lme4)

# 2. data -----------------------------------------
load('data/gpa.RData')
head(gpa)

# 3. fit standard linear model --------------------
gpa_lm = lm(gpa ~ occasion, data=gpa)
summary(gpa_lm)

# 4. fit mixed models -----------------------------
gpa_mixed = lmer(gpa ~ occasion + (1|student), data=gpa)
summary(gpa_mixed)

# confidence interval
confint(gpa_mixed)

# random effects
ranef(gpa_mixed)$student 
coef(gpa_mixed)$student

# prediction
predict(gpa_mixed, re.form=NA) %>% head
