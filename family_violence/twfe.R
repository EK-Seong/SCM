library(readxl)
library(tidyverse)

d <- readxl::read_excel("final_1821.xlsx",col_names = TRUE)

d <- as.data.frame(d)
Dt <- d$period >= 26
Ddaegu <- d$region == 3
DtDdaegu <- Dt*Ddaegu
Dt <- as.integer(Dt)
Ddaegu <- as.integer(Ddaegu)
d <- cbind(d,Dt,Ddaegu,DtDdaegu)

sample <- (d$region != 1)&(d$region != 5)&(d$region != 8)&(d$region != 14)
dsubset <- subset(d,subset = sample)

twfe = lm(reports_per~Dt+Ddaegu+DtDdaegu+unemploy_rate_male+unemploy_rate_female+
            hotdays+aver_age+income_per+log_male+log_female+crime_thousand
          ,dsubset)

summary(twfe)

beta <- twfe$coefficients

daegu <- subset(d,subset = as.logical(Ddaegu))
unit_root <- lm(reports_per[2:48]~reports_per[1:47]-1,daegu)
summary(unit_root)

pnorm((0.99100-1)/0.01433,mean = 0,sd = 1)

unit_root2 <- lm(log_reports_per[2:48]~log_reports_per[1:47]-1,daegu)
summary(unit_root2)
