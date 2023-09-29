#loading formatted source data
step1_pfas <- read.csv("MAFALDA_PFAS_formatted_final.csv", header=T, row.names =1, sep = "\t", strip.white = F)

#replace all zeros "0" with NA
step1_pfas[step1_pfas == 0] <- NA
write.table(step1_pfas, "step1_pfasNA_op.txt", row.names=T, col.names=NA, sep="\t", quote=F)


#find > 50% missing values
nacounts_pfas <- colSums(is.na(step1_pfas))
write.table(nacounts_pfas, "nacounts_pfas.txt", row.names=T, col.names=NA, sep="\t", quote=F)
#Calculate % missing values by number of samples/observation, not variables

#impute half minimums
library(tidyverse)
step2_pfas_hmins <- step1_pfas %>%
  mutate_if(is.numeric, function(x) ifelse(is.na(x), min(x/2, na.rm = T), x))
write.table(step2_pfas_hmins, "step2_pfas_hmins_op.txt", row.names=T, col.names=NA, sep="\t", quote=F)

#log2 transformation
step3_pfas_hmins_logged <- log2(step2_pfas_hmins)
write.table(step3_pfas_hmins_logged, "step3_pfas_hmins_logged_op.txt", row.names=T, col.names=NA, sep="\t", quote=F)


#Auto-scaling
step4_pfas_hmins_logged_scaled <- as.data.frame(scale(step3_pfas_hmins_logged))

write.table(step4_pfas_hmins_logged_scaled, "step4_pfas_hmins_logged_scaled_op.txt", row.names=T, col.names=NA, sep="\t", quote=F)