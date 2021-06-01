library(tidyverse)

bechdel_raw <- read.csv("movies.csv")

#rename some cols
bechdel_clean <- bechdel_raw %>%
  rename(budget_2013 = budget_2013., 
         domgross_2013 = domgross_2013., 
         intgross_2013 = intgross_2013.)

#remove unnecessary columns 
bechdel_clean <- bechdel_clean %>%
  mutate(period.code = NULL, 
         decade.code = NULL, 
         code = NULL, 
         budget = NULL, 
         domgross = NULL, 
         intgross = NULL, 
         imdb = NULL)

#make NA vales 
bechdel_clean <- bechdel_clean %>% 
  mutate(domgross_2013 = na_if(domgross_2013, "#N/A"), 
         intgross_2013 = na_if(intgross_2013, "#N/A"))

#make factors 
bechdel_clean <- bechdel_clean %>% 
  mutate(test = factor(test), 
         clean_test = factor(clean_test), 
         binary = factor(binary))

#make some variables numeric
bechdel_clean <- bechdel_clean %>% 
  mutate(domgross_2013 = as.numeric(domgross_2013),
         intgross_2013 = as.numeric(intgross_2013))

#move title to first col
bechdel_clean <- bechdel_clean %>% 
  relocate(title, .before = year)

#re-save the data
write.csv(bechdel_clean, file = "bechdel_clean.csv")
