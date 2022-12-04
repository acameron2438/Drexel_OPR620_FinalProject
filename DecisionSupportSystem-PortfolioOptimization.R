######################################################################################
## Porfolio Decision Support System                                                 ##
## Instructions: To use the decision support system, right click in this space and  ##
## choose "select all". Then click the "Run" button above. Enter your preferences   ##
## into the dialog box. The results will appear below in the Console. Graphics will ##
## Display in the plots tab in the lower right-hand corner of your screen.          ##
######################################################################################

#The code for the decision support system is written beneath this text.#

require("quantmod")

require(fImport)

require(data.table)

require(reshape2)

require(dplyr)

require(sqldf)

install.packages("lpSolve")

library("lpSolve", lib.loc="C:/R/R-3.1.1/library")

set.seed(1)

#stocks,treasury bonds and gold

symbols1<-c("AAPL","BAC","AMZN","GOOG","ABBV","DIA","SBIO","EMLP","SPHD","YAO","IGDAX","WSGAX","WDHYX","VLTCX","VITAX")

rawdata1<-data.frame(yahooSeries(symbols1,from="2010-01-01",to=Sys.Date()))

getSymbols("AAPL;BAC;AMZN;GOOG;ABBV;DIA;SBIO;EMLP;SPHD;YAO;IGDAX;WSGAX;WDHYX;VLTCX;VITAX",from="2010-01-01",to=Sys.Date())

## some of the above returns have negative values
# The above code doesn't save the date as a column name.
# Change the date column to properly show as Date

Closing_prices <- setDT(rawdata1,keep.rownames=TRUE)[]

#setnames(data2,"rn","Date")
# Return only the columns that are Date or adjusted closing price

Closing_prices <- as.data.frame(Closing_prices)

cols <- c(grep(".Close",names(Closing_prices),value=TRUE))

Closing_prices <- Closing_prices[,cols]

ret<-c(mean(dailyReturn(AAPL)),mean(dailyReturn(BAC)),mean(dailyReturn(AMZN)),mean(dailyReturn(GOOG)),mean(dailyReturn(ABBV)),mean(dailyReturn(DIA)),mean(dailyReturn(SBIO)),mean(dailyReturn(EMLP)),mean(dailyReturn(SPHD)),mean(dailyReturn(YAO)),mean(dailyReturn(IGDAX)),mean(dailyReturn(WSGAX)),mean(dailyReturn(WDHYX)),mean(dailyReturn(VLTCX)),mean(dailyReturn(VITAX)))

risk<-c(var(dailyReturn(AAPL)),var(dailyReturn(BAC)),var(dailyReturn(AMZN)),var(dailyReturn(GOOG)),var(dailyReturn(ABBV)),var(dailyReturn(DIA)),var(dailyReturn(SBIO)),var(dailyReturn(EMLP)),var(dailyReturn(SPHD)),var(dailyReturn(YAO)),var(dailyReturn(IGDAX)),var(dailyReturn(WSGAX)),var(dailyReturn(WDHYX)),var(dailyReturn(VLTCX)),var(dailyReturn(VITAX)))

#for(i in 1:25)
#{
#  for(j in 1:25)
#  {
#   if (corr[i,j]>0.7) corr[i,j]=0
#}
#}
#constraints
#budget

temp<-matrix(c(Closing_prices[nrow(rawdata1),],dimnames = NULL),ncol=30)

temp<-temp[, seq(1, ncol(temp), by = 2)]

temp1<-as.numeric(temp)

for(i in 1:15){
  
  risk[i]=risk[i]*temp1[i]
  
}

for(i in 1:15){
  
  ret[i]=ret[i]*temp1[i]
  
}

div<-matrix(c(0),nrow=15,ncol=15);

for(i in 1:15){
  
  for (j in 1:15){
    
    if(i==j)div[i,j]=temp1[j] else div[i,j]=0
    
  }}

# average number of stocks that can be bought

avg_no_stocks<-10000/(mean(Closing_prices[nrow(Closing_prices),1]))

cl_prices<-temp1

con<-matrix(c(cl_prices,risk,div,div,
              
              Closing_prices[nrow(Closing_prices),1],Closing_prices[nrow(Closing_prices),2],Closing_prices[nrow(Closing_prices),3],Closing_prices[nrow(Closing_prices),4],Closing_prices[nrow(Closing_prices),5],rep(0,10),
              
              rep(0,5),Closing_prices[nrow(Closing_prices),6],Closing_prices[nrow(Closing_prices),7],Closing_prices[nrow(Closing_prices),8],Closing_prices[nrow(Closing_prices),9],Closing_prices[nrow(Closing_prices),10],rep(0,5),
              
              rep(0,10),Closing_prices[nrow(Closing_prices),11],Closing_prices[nrow(Closing_prices),12],Closing_prices[nrow(Closing_prices),13],Closing_prices[nrow(Closing_prices),14],Closing_prices[nrow(Closing_prices),15],
              
              Closing_prices[nrow(Closing_prices),1],Closing_prices[nrow(Closing_prices),2],Closing_prices[nrow(Closing_prices),3],Closing_prices[nrow(Closing_prices),4],Closing_prices[nrow(Closing_prices),5],rep(0,10),
              
              rep(0,5),Closing_prices[nrow(Closing_prices),6],Closing_prices[nrow(Closing_prices),7],Closing_prices[nrow(Closing_prices),8],Closing_prices[nrow(Closing_prices),9],Closing_prices[nrow(Closing_prices),10],rep(0,5),
              
              rep(0,10),Closing_prices[nrow(Closing_prices),11],Closing_prices[nrow(Closing_prices),12],Closing_prices[nrow(Closing_prices),13],Closing_prices[nrow(Closing_prices),14],Closing_prices[nrow(Closing_prices),15]),
            
            nrow=38,ncol=15,byrow=T)

dir<-c("<=","<=",rep("<=",15),rep(">=",15),">=",">=",">=","<=","<=","<=")

obj<-c(ret)

#User Interface- Uses Package "fgui"

library("fgui", lib.loc="C:/R/R-3.1.1/library")

require(fgui)
DSS1<-function(Budget,P_Risk,Upper_Bound_Per_Asset,Lower_Bound_Per_Asset,Lower_Bound_Stocks,Lower_Bound_ETF,Lower_Bound_IF,Upper_Bound_Stocks,Upper_Bound_ETF,Upper_Bound_IF)
  
{
  
  lp('max',obj,con,dir,const.rhs=c(Budget,P_Risk,rep(Upper_Bound_Per_Asset,15),rep(Lower_Bound_Per_Asset,15),Lower_Bound_Stocks,Lower_Bound_ETF,Lower_Bound_IF,Upper_Bound_Stocks,Upper_Bound_ETF,Upper_Bound_IF),int.vec = 1:15)$solution
  
}

DSS<-function(Budget,P_Risk,Upper_Bound_Per_Asset,Lower_Bound_Per_Asset,Lower_Bound_Stocks,Lower_Bound_ETF,Lower_Bound_IF,Upper_Bound_Stocks,Upper_Bound_ETF,Upper_Bound_IF)
  
{
  
  lp('max',obj,con,dir,const.rhs=c(Budget,P_Risk,rep(Upper_Bound_Per_Asset,15),rep(Lower_Bound_Per_Asset,15),Lower_Bound_Stocks,Lower_Bound_ETF,Lower_Bound_IF,Upper_Bound_Stocks,Upper_Bound_ETF,Upper_Bound_IF),int.vec = 1:15)$solution
  
}

options(warn=-1)

results=guiv(func = DSS)

options(warn=0)

results

# Pie Chart with Percentages
slices <- c(results)

lbls <- c("AAPL","BAC","AMZN","GOOG","ABBV","DIA","SBIO","EMLP","SPHD","YAO","IGDAX","WSGAX","WDHYX","VLTCX","VITAX")

pct <- round(slices/sum(slices)*100)

lbls <- paste(lbls, pct) # add percents to labels 

lbls <- paste(lbls,"%",sep="") # ad % to labels 

pie(slices,labels = lbls, radius=1.3, col=rainbow(length(lbls)),
    main="Portfolio Allocation")

# 3D Exploded Pie Chart

library(plotrix)

slices <- c(results)

lbls <- c("AAPL","BAC","AMZN","GOOG","ABBV","DIA","SBIO","EMLP","SPHD","YAO","IGDAX","WSGAX","WDHYX","VLTCX","VITAX")

pie3D(slices,labels=lbls, radius=1.3, explode=0.1,
      main="Portfolio Allocation2") 

#Console Output
results2=sum(ret*results)

paste("amt invested is",sum(temp1*results))
paste("daily return is ",results2)
paste("Monthly return is ",results2*30)
paste("Quaterly return is ",results2*120)
paste("Yearly return is ",results2*365)