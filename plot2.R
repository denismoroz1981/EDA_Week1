#data reading and formatting
#setwd("c:\\Users\\User\\Documents\\R projects\\Reprodud analysis\\Week 1")
df<-read.table("household_power_consumption.txt",header = TRUE,sep=";")
df_w<-df
df_w$Date<-as.Date(df_w$Date,format="%d/%m/%Y")
df_w$Global_active_power<-as.numeric(df_w$Global_active_power)

#data subsetting
dff<-df_w[df_w$Date %in% as.Date(c("2007-02-01","2007-02-02")),]

#adding column with Date+Time
library(dplyr)
dffm<-mutate(dff,DateTime=paste(Date,Time))
dffm$DateTime<-strptime(dffm$DateTime,format = "%Y-%m-%d %H:%M:%S")

#plotting
png("plot2.png",width=480,height = 480)
plot(dffm$DateTime,dffm$Global_active_power,ylab="Global Active Power (kilowatts)",yaxt="n",xlab="",pch=26)
lines(dffm$DateTime,dffm$Global_active_power)
axis(2,at=seq(0,3000,by=1000),labels = c("0","2","4","6"))
dev.off()