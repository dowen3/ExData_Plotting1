download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "exdata-data-household_power_consumption.zip")
unzip("exdata-data-household_power_consumption.zip")
data <- read.table("household_power_consumption.txt", sep=";", skip=1);
data$V1<-as.Date(data$V1, format = "%d/%m/%Y" )
sub<-data[data$V1=="2007-02-01"|data$V1=="2007-02-02",];
titles<-read.table("household_power_consumption.txt",sep=";",nrows=1);
titles<-lapply(titles, as.character)
colnames(sub)<-titles

sub<-within(sub, { timestamp=format(as.POSIXct(paste(Date, Time)), "%Y/%m/%d %H:%M:%S") })
sub$timestamp<-strptime(sub$timestamp, format = "%Y/%m/%d %H:%M:%S")

indx <- sapply(sub, is.factor)
sub[indx]<-lapply(sub[indx], as.character)
sub[indx]<-lapply(sub[indx], as.numeric)

png(filename= "Plot 3.png", width = 480, height = 480)
plot(sub$timestamp, sub$Sub_metering_1, ylab="Energy sub metering", type="l", xlab="")
lines(sub$timestamp, sub$Sub_metering_2, col="red")
lines(sub$timestamp, sub$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red", "blue"))

dev.off()
