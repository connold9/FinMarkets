# -*- coding: utf-8 -*-
"""
Spyder Editor

import nump

This is a temporary script file.
"""

import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression

ff_data = pd.read_csv("F-F_Research_Data_Factors.CSV", index_col = 'Date' )
portfolios_data = pd.read_csv("Portfolios_Formed_on_BETA.csv", index_col = 'Date' )

sub_ff = ff_data.loc['196307':'201906']
sub_pf = portfolios_data.loc['196307':'201906']

index1 = sub_ff.index
sub_pf.index = index1

monthly_prices = pd.concat([sub_ff,sub_pf], axis = 1)

monthly_prices["SMB"] = pd.to_numeric(monthly_prices.SMB, errors='coerce')
monthly_prices["HML"] = pd.to_numeric(monthly_prices.HML, errors='coerce')
monthly_prices["RF"] = pd.to_numeric(monthly_prices.RF, errors='coerce')
monthly_prices["Mkt-RF"] = pd.to_numeric(monthly_prices["Mkt-RF"], errors='coerce')

monthly_prices.dtypes
means = monthly_prices.mean()
annualized_means  = means * 12
decile_means = means[9:19]*12

def betas(data):
    """ Fits regression line and return beta """
    betas = []
    
    for col in data.columns[9:19]:
            reg = LinearRegression()
            reg.fit(data[['Mkt-RF']].values, (data[col] - data['RF']).values.reshape(-1, 1))
            betas.append(reg.coef_[0][0])

    return betas

# Obseve betas, should be monotonic increasing
betas = betas(monthly_prices)


"""
# make regression model 
model = sm.OLS(y_var, x)
results = model.fit()
print(results.summary())
print(results.params[1])
"""

"""
deciles_df = monthly_prices.iloc[:, 9:19]
risk_free = monthly_prices["RF"]
subtracted = deciles_df.sub(risk_free,axis=0)

betas = []

cols = list(deciles_df.head())

for i in cols:
    x_var = deciles_df[[i]]
    x = sm.add_constant(x_var)
    y_var = monthly_prices[["Mkt-RF"]]

    # make regression model 
    model = sm.OLS(y_var, x)
    results = model.fit()
    print(results.params[1])
    betas.append(results.params[1])
"""

