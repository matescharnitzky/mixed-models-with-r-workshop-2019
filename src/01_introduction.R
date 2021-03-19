
# 1. packages -------------------------------------

library(tidyverse)
library(lme4)

# 1. fit: linear model ----------------------------
lm_model = lm(Reaction ~ Days, data = sleepstudy)
summary(lm_model)

# 2. fit: mixed model -----------------------------

mixed_model = lmer(Reaction ~ Days + (1 + Days|Subject), data = sleepstudy)
summary(mixed_model)

print(VarCorr(mixed_model), comp=c('Var', 'Std')) 

# random effects
random_effects = ranef(mixed_model)$Subject
random_effects

random_coefficients = coef(mixed_model)$Subject

# fixed effects
fixed_effects = fixef(mixed_model)
random_effects  = 
  random_coefficients %>% 
  mutate(Subject = factor(unique(sleepstudy$Subject)))

sleepstudy %>% 
  ggplot(aes(Days, Reaction)) +
  geom_point(aes(color = Subject), alpha = .25) +
  geom_abline(
    aes(
      intercept = fixed_effects['(Intercept)'],
      slope = fixed_effects['Days']),
    color = 'darkred',
    size = 2) +
  geom_abline(
    aes(
      intercept = `(Intercept)`, 
      slope = Days,
      color = Subject),
    size = .5,
    alpha = .25,
    data = random_effects) 