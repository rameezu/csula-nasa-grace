time_point = c(1:144);

GRACE.data = data.frame(time_point, GRACE_time_month, GRACE_ocean_avg); #manually import time_month and ocean_avg dataGRA
names(GRACE.data)[names(GRACE.data)=="V1"] <- "month";
names(GRACE.data)[names(GRACE.data)=="V1.1"] <- "ocean_avg";

# plot average value by month
boxplot(ocean_avg ~ month,col=c("lightgray"),GRACE.data, 
          main="Ocean Volume by Month", 
          xlab="Month", ylab="Equivalent Water Thickness (cm)");

# lme model
library(lme4)
GRACE.model = lmer(ocean_avg ~ time_point + (1|month), data=GRACE.data, REML=FALSE);
summary(GRACE.model)
p
# test for significance
GRACE.modelNull = lmer(ocean_avg ~ 1 + (1|month), data=GRACE.data, REML=FALSE);
anova(GRACE.modelNull, GRACE.model)
