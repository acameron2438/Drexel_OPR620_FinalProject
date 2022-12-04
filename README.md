# Drexel_OPR620_FinalProject

A project I completed for the class Operations Research 1 while completing a master's degree at Drexel University

Summary:

My decision support system uses linear programming to optimize an investment portfolio. In in the initial steps, the script imports data like the opening prices and closing prices for 15 assets taken from yahoo’s financial website. It stores this data in a data frame so the script can later get the previous day’s closing price for each asset. This is then used as the coefficients in the linear programming model. The script pulls in the daily returns for all 15 assets, which is used to calculate the average return and risk of each. When I ran the model in class I used the following contraints:

1) The risk factor (p) is equal to 5 units.
2) Invest no more than $8,000 in any of the three assets classes. 
3) Invest at least $2,000 in each of the three asset classes (Stockes, ETF, Index Funds).
4) Invest no more than $10,000
5) Buy at least one of each asset

The decision support system maximizes the return on investment even if that means it doesn't invest all the money. The decision support system provides the expected returns on daily, monthly, quarterly and yearly basis assuming the market conditions remain the same.

User interface for the decision support system:

![image](https://user-images.githubusercontent.com/103590679/205519017-ce4e0f89-3d2c-49c2-88b0-699f40d6a950.png)

Results at the time the system was run:

Amount investedL: $9997.68

Daily return: $9.77
Monthly return: $293.19
Annual return: $3567.24

Assets Purchased:

AAPL 1 

BAC 1

AMZN 13

GOOG 1

ABBV 13

DIA 1

SBIO 1

EMLP 1

SPHD 1

YAO 1

IGDAX 2

WSGAX 9

WDHYX 1

VLTCX 1

VITAX 9

Pie chart generated from the system:

![image](https://user-images.githubusercontent.com/103590679/205519176-57dd4bb0-25b5-417b-adcb-8f3187bae491.png)



