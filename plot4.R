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
png("plot4.png",width=480,height = 480)
par(mfrow=c(2,2))
#graph 1
plot(dffm$DateTime,dffm$Global_active_power,ylab="Global Active Power (kilowatts)",yaxt="n",xlab="",pch=26)
lines(dffm$DateTime,dffm$Global_active_power)
axis(2,at=seq(0,3000,by=1000),labels = c("0","2","4","6"))
#graph 2
plot(dffm$DateTime,dffm$Voltage,ylab="Voltage",yaxt="n",xlab="datetime",pch=26)
lines(dffm$DateTime,dffm$Voltage)
axis(2,at=seq(800,2200,by=200),labels = c("234","","238","","242","","246",""))
#graph 3
plot(dffm$DateTime,dffm$Sub_metering_1,ylab="Energy sub metering",yaxt="n",xlab="",pch=26)
lines(dffm$DateTime,dffm$Sub_metering_1)
lines(dffm$DateTime,dffm$Sub_metering_2,col="red")
lines(dffm$DateTime,dffm$Sub_metering_3,col="blue")
axis(2,at=seq(0,35,by=10))
legend("topright",lty=c(1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#graph 4
plot(dffm$DateTime,dffm$Global_reactive_power,ylab="Global_reactive_power",yaxt="n",xlab="datetime",pch=26)
lines(dffm$DateTime,dffm$Global_reactive_power)
axis(2,at=seq(0,250,by=50),labels = c("0","0.1","0.2","0.3","0.4","0.5"))
dev.off()