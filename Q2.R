#Q2

msft_data <- read.csv("MSFT_ret_crsp.csv", row.names = "ym")
ko_data <- read.csv("KO_ret_crsp.csv", row.names = "ym")
GM_data <- read.csv("GM_ret_crsp.csv", row.names = "ym")
msft_ret <- msft_data[, 4]
msft_ret
mrkt <- read.csv("F-F_Research_Data_Factors.csv", row.names = "Date")
portfolios <- read.csv("Portfolios_Formed_on_BETA.csv", row.names = "Date")


merged <- merge(ko_data, msft_data, by=0, all.x=TRUE, row.names = "row.names")
rownames(merged) =  merged[,1]
merged = merged[,-1]
merged <- merge(merged, GM_data, by = 0, all.x = T)
rownames(merged) =  merged[,1]
merged = merged[,-1]
merged = merged[, c(4,9,14)]
colnames(merged) = c("KO", "MSFT", "GM")
merged = merge(merged, mrkt/100, by = 0, all.x = T)
rownames(merged) =  merged[,1]
merged = merged[,-1]


