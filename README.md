# Drexel_OPR620_FinalProject
A project I completed for the class Operations Research 1 while completing a master's degree at Drexel University

Technical Report:

The objective is to build a portfolio for an investment of $10,000. I decided to divert the investment into 3 asset classes namely Stocks, Mutual funds, Indices. The objective is to guide the customer to make investments in portfolios that will maximize profits. The fund manager decides to pick five financial instruments from each of these three asset classes.

Decision Support System:
The primary objective for my decision Support System is to tell our customer where he can do with his investment for max return for a certain period he desires. From a variety of classes were I can invest I have picked five from each category.  From this I need to select the most optimal stocks to invest in which maximizes the returns for the investor. The decision support system is intentionally developed for investment to select the securities in the stock market, from a properly diversified stock portfolio, by using multi-criteria decision making technique. At least one stock must be picked from each category, and weight for each stock is calculated along with the risk involved with it, lower and upper bound for the individual instruments, and the same for asset classes, stock need to be integers, total budget. The decision support system can be used to visualize the investments for the selected stock over a period desired, based on this one can check how the stock has performed over a period of time. I have shown candle and bar graph charts for 6 months for three randomly selected stocks. I am calculating the simple returns along with risk involved with that stock using the Variance. Based on the above correlation I draw my covariance matrix to check which all stocks I can invest in. Ideally stock with positive and negative correlation are chosen so that in case the market goes down I may not lose my entire investment. To visualize it in a better way I plot the risk vs return chart for the selected securities. Using all the data I have gathered above I draw my efficient frontier to select the best possible options I have to maximize my returns. The results from the efficient frontier that are produce by quadratic programming are verified using linear optimization techniques. I provide all my inputs to my linear program to give us the best possible options and the quantity of the stocks that I can invest. The initial solution from the LP provides a daily return which is later converted into monthly, quarterly and yearly returns assuming market conditions won’t change over period of that time. Once the client and portfolio manager have discussed in which stocks to invest in the program I have developed will tell the manager which particular stocks to invest in.

Model Assumptions and details:
Modern portfolio theory is used to model the portfolio. The model used is a mathematical framework for assembling a portfolio of assets such that the expected return is maximized for a given level of risk, defined as variance. The key insight is that an asset's risk and return should not be assessed by itself, but by how it contributes to a portfolio's overall risk and return.
Modern portfolio theory assumes that investors are risk averse, meaning that given two portfolios that offer the same expected return, investors will prefer the less risky one. Thus, an investor will take on increased risk only if compensated by higher expected returns. Conversely, an investor who wants higher expected returns must accept more risk. The exact trade-off will be the same for all investors, but different investors will evaluate the trade-off differently based on individual risk aversion characteristics. The implication is that a rational investor will not invest in a portfolio if a second portfolio exists with a more favorable risk-expected return profile – i.e., if for that level of risk an alternative portfolio exists that has better expected returns.
I first use the efficient frontier technique which is based on the modern portfolio theory to determine the most optimal financial instruments to invest in and this model picks financial instruments from a well-diversified portfolio using a multiple criteria decision system. Then I use linear programming model in order to cross validate if the investments are made into the same financial instruments that are resulted from the efficient frontier model. The following criteria or constraints were used to build the portfolio model:
At least one financial instrument must be selected from each of the three asset categories.
The risk of the model should be less than or equal to 5.
Each stock can at most be bought for $8000.
Stocks need to be bought in integers.
At most $5000 to be invested in each asset class as a whole.
Efficient Frontier. The hyperbola is sometimes referred to as the 'Markowitz Bullet', and is the efficient frontier if no risk-free asset is available. With a risk-free asset, the straight line is the efficient frontier.  The upper edge of this region is the efficient frontier in the absence of a risk-free asset. Combinations along this upper edge represent portfolios (including no holdings of the risk-free asset) for which there is lowest risk for a given level of expected return. Equivalently, a portfolio lying on the efficient frontier represents the combination offering the best possible expected return for given risk level. 

I am using a combination of quadratic programming as well as linear programming in R for creation and verification of the model. Quadratic programming is basically used to create an efficient frontier for the selected financial instruments to check the most efficient instruments to invest in taking in account of risk as well as the returns. There are various charts being drawn to check how the instruments have performed in previous 6 months. Linear programming is used to verify my results from the efficient frontier. I created a UI in R to input the values for budget and various other constraints that will provide me with the desired results. A minimum understanding of R programming is required as selecting the entire code and how to run it. Once ran the UI will be presented from where I can provide my values and obtain the results.  Running the linear program provides me with the number of stocks (and a pie chart providing the percent allocation) that I can buy with certain constraints in place which are described later in this document.  Below mentioned is the model that has been used for the quadratic programming. A brief introduction to the Modern Portfolio Theory is also provided as to why I selected this model.

Model:

Model creation is based on the Modern portfolio theory (MPT), or mean-variance analysis, is a mathematical framework for assembling a portfolio of assets such that the expected return is maximized for a given level of risk, defined as variance. Its key insight is that an asset's risk and return should not be assessed by itself, but by how it contributes to a portfolio's overall risk and return.
MPT assumes that investors are risk averse, meaning that given two portfolios that offer the same expected return, investors will prefer the less risky one. Thus, an investor will take on increased risk only if compensated by higher expected returns. Conversely, an investor who wants higher expected returns must accept more risk. The exact trade-off will be the same for all investors, but different investors will evaluate the trade-off differently based on individual risk aversion characteristics. The implication is that a rational investor will not invest in a portfolio if a second portfolio exists with a more favorable risk-expected return profile – i.e., if for that level of risk an alternative portfolio exists that has better expected returns.

Expected return:

![image](https://user-images.githubusercontent.com/103590679/205516844-842675f5-4298-4d9c-b1ab-7f2d5790fb7e.png)

where  is the return on the portfolio,  is the return on asset i and  is the weighting of component asset  (that is, the proportion of asset "i" in the portfolio).

Portfolio return variance:

![image](https://user-images.githubusercontent.com/103590679/205516870-4768e9b6-c015-43ac-b6cd-987dc77011a1.png)

where  is the correlation coefficient between the returns on assets i and j. Alternatively the expression can be written as:

![image](https://user-images.githubusercontent.com/103590679/205516897-af32aa68-4b63-4920-87cc-43fe1635343e.png)

where  for i=j. Risk is calculated using the variance and applied to the historical returns to check the deviation in the pricing
Portfolio return volatility (standard deviation):

The first step is to load the quantmod and the related dependencies. After the package is loaded I need to get the data for the stocks and related items for which I need to check my portfolio for optimization. I am using getsymbols functions to extract the data form yahoo finance for the term specified (here I am checking data for 6 years(month end data) as historical returns. If there are any missed values I will delete that row using the omit function, so that I may not encounter any error while running the program.

Returns:
Using the historical monthly prices I will calculate the simple returns (as specified by type=discrete) using the function ROC in quantmod. To check my expected returns I am calculating the mean of the historical prices for all my stocks in accordance to the Modern portfolio theory. 
 
 Risk:
To calculate the risk I am looking at the variance for all the historical returns. Why I am using variance as my measure for the risk? Variance measures the average amount by which individual data points differ from the mean. The more volatile a security, the larger the variance. 

Correlation and Covariance:
The next step is to calculate the correlation between the various stocks, the most diversified portfolio consists of securities with the greatest negative correlation. A diversified portfolio can also be achieved by investing in uncorrelated assets, but there will be times when the investments will be both up or down, and thus, a portfolio of uncorrelated assets will have a greater degree of risk, but it is still significantly less than positively correlated investments. However, even positively correlated investments will be less risky than single assets or investments that are perfectly positively correlated. However, there is no reduction in risk by combining assets that are perfectly correlated.

I assign an annual factor for how many months an investor wants to invest and with this factor I may find the expected return and risk relate to that time period of investment. If the risk factor is coming out to be zero I assign a very minute value because there cannot be any investment without a risk. The covariance matrix is calculated using the risk and the correlations between the various stocks. Covariance calculations can give an investor insight into how two stocks might move together in the future. Looking at historical prices, I can determine if the prices tend to move with each other or opposite each other. This allows you to predict the potential price movement of a two-stock portfolio. I might even be able to select stocks that complement each other, which can reduce the overall risk and increase the overall potential return. In the stock market, a strong emphasis is placed on reducing the risk amount taken on for the same amount of return. When constructing a portfolio, an analyst will select stocks that will work well together. This usually means that these stocks do not move in the same direction. 

Visualization:
I plot charts for all the stocks that I have considered to check visually how they have performed over the time period. My first output will be the return and risk along with the covariance matrix and display each asset in the Risk - Return plot. Visualizing this I can check what are the risk and returns related to my assets. My final part will be to create an efficient frontier to check if what I have invested in fall under the right curve or not. Here I add constraints to my portfolios with allocations to any asset class ranging between 20% and 80% and total portfolio weight equal to 100% which I can vary as desired. I can create multiple portfolios here with the above data to have a clear picture of my investments (constraints here are specifying the cov matrix). The Transition Map displays portfolio weights as we move along the efficient frontier. I am displaying portfolio risk along the X axis, and portfolio weights along the Y axis. The width of the slice represents the portfolio weight for the given risk level. Below are the various functions and other terminologies used for the portfolio optimization.

Drawbacks:
There may be few problems with these assumptions that historical mean might not be a good proxy for expected returns while weighted historical mean maybe a better choice because it puts more weight on the recent observations but this model I will be using the means as my proxy. Correlations are not stable as when the risks show up (typically during times of financial and/or political crises), correlations among all asset classes tend to turn high. Just when the benefits of diversification are needed most, they go AWOL. Volatility tends to cluster or Volatility Clustering captures the idea that some markets represent periods of notably high or low volatility. Large positive and negative changes in prices tend to be followed by large changes, and small changes tend to be followed by small changes.

Description of functions and framework used:

Quantitative Financial Modelling Framework: The quantmod package for R is designed to assist the quantitative trader in the development, testing, and deployment of statistically based trading models

Functions Used:

Spl: functions used to split  the symbols

getSymbols: Functions to load and manage Symbols in specified environment
Current src methods available are: yahoo, google, MySQL, FRED, csv, RData, and oanda.
Data is loaded silently without user assignment by default.
Using auto.assign=TRUE, the variable chosen is an R-legal name derived from the symbol being loaded.
Objects loaded by getSymbols with auto.assign=TRUE can be viewed with showSymbols 
Finally, if none of the other source rules apply the default getSymbols src method is used (‘yahoo’).

Merge: Merge two data frames by common columns or row names.

Endpoints: Extract index values of a given xts object corresponding to the last observations given a period specified by on. Endpoints returns a numeric vector corresponding to the last observation in each period specified by on, with a zero added to the beginning of the vector, and the index of the last observation in x at the end.
Valid values for the argument on include: “us” (microseconds), “microseconds”, “ms” (milliseconds), “milliseconds”, “secs” (seconds), “seconds”, “mins” (minutes), “minutes”, “hours”, “days”, “weeks”, “months”, “quarters”, and “years”.

CL:  The function is called whenever the symbol object satisfies the has Cl assertion. Quantmod comes with Cl function to check if a particular symbol contains a series representing the closing price. This is necessary since all names in the symbol object are prefixed by the literal string symbol. Hence the close series for GLD is GLD.Close , stock_data comes back as a list of xts objects identified by the ticker with the rows of each element as a date value and the columns a series of ticker-related data (open, close, etc.). Close_prices should be a list or data frame of only the closing price column of all tickers (i.e, the closing price column from a stock, the closing price column from stock, etc.).

na.omit: to remove the missing data.

ROC: Rate of Change
I need to calculate simple returns, which are (today's_close - yesterday's_close) / yesterday's_close. To calculate the simple returns ROC function in the quantmod package can be used. Simple returns are referred to as arithmetic, discrete or simple in the above functions. The log returns are alternately referred to as log, continuous or compound. So I am using discrete to calculate the simple returns.

Apply: apply(X, MARGIN, FUN, ...)

MARGIN: a vector giving the subscripts which the function will be applied over. E.g., for a matrix 1indicates rows, 2 indicates columns, c(1, 2) indicates rows and columns. 

Iif:IIf ( expr , truepart , falsepart )

REP: rep replicates the values in x. It is a generic function

Portopt: The first step to create efficient frontier is to find the top,right (maximum return portfolio) and bottom,left (minimum risk portfolio).Next, I divide the return space between minimum risk portfolio and maximum return portfolio into n portfolios equally spaced points. For each point, we find minimum risk portfolio with additional constraint that portfolio return has to be equal target return for this point. The last step is to compute returns and risks for portfolio on efficient frontier.

Other terminologies used:

Covariance is one measure of the degree to which the returns of two risky assets move in tandem (having two things arranged one in front of the other). A positive covariance means that asset returns move together, while a negative covariance means returns move inversely (in an opposite direction).  Covariance matrix for multiple securities to see how the annual returns of these stocks have moved in relation to each other over the last years. When we create a covariance matrix in this manner, half of the resulting table is empty. This is because covariance matrices are symmetric, meaning that the cells in the upper diagonal would be a mirror image of those in the lower diagonal.
Expected return is by no means a guaranteed rate of return. However, it can be used to forecast the future value of a portfolio, and it also provides a guide from which to measure actual returns.
Variance is a measure of the dispersion of a set of data points around their mean value. In other words, variance is a mathematical expectation of the average squared deviations from the mean. It is computed by finding the probability-weighted average of squared deviations from the expected value. Variance measures the variability from an average (volatility). Volatility is a measure of risk, so this statistic can help determine the risk an investor might take on when purchasing a specific security. A measure of the dispersion of a set of data from its mean. The more spread apart the data, the higher the deviation. 
Pearson r correlation is widely used in statistics to measure the degree of the relationship between linear related variables.  For example, in the stock market, if I want to measure how two commodities are related to each other, Pearson r correlation is used to measure the degree of relationship between the two commodities.
By definition the efficient frontier are those portfolios with the maximum amount of return per unit of risk, or conversely the lowest amount of risk per unit of return and is driven by the constraints I have placed on the efficient frontier. The goal is to maximize return and minimize risk, based purely and only on the three inputs- return, risk and correlation Limits are placed on the optimization to get realistic portfolios. By capping exposure to certain asset classes, the highest possible potential return gets lowered. The efficient frontier gets shorter. 
