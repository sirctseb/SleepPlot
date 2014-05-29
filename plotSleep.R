library(ggplot2)
library(plyr)

# load data table
sleep <- read.table('sleeps.csv', header=TRUE, sep=',')

# transform into usable data
df <- ddply(sleep, .(id), function(df) {
	format <- '%H:%M:%S %m-%d-%Y'
	start <- strptime(df[1,2], format)
	end <- strptime(df[1,3], format)
	xmin <- (start$hour + start$min/60)
	xmax <- (end$hour + end$min/60)
	if(end$mday > start$mday) {
		xmax <- xmax + 24
	}
	data.frame(xmin = xmin, xmax = xmax, x = xmin, y = start$yday)
})

print(ggplot() + geom_errorbarh(aes(xmin = df$xmin, xmax = df$xmax, x = df$x, y = df$y)))
