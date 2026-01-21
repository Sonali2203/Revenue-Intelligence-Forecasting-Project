import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_absolute_error

print("ML Revenue Forecasting Started")

# Load data
df = pd.read_csv("monthly_revenue.csv")

df['month'] = pd.to_datetime(df['month'])
df = df.sort_values('month')

print("Data preview:")
print(df.head())

# Feature engineering
df['time_index'] = np.arange(len(df))

# Train model
X = df[['time_index']]
y = df['monthly_revenue']

model = LinearRegression()
model.fit(X, y)

df['predicted_revenue'] = model.predict(X)

# Validation
mae = mean_absolute_error(y, df['predicted_revenue'])
print("Model MAE:", round(mae, 2))

# Forecast next 6 months
future_periods = 6
future_index = np.arange(len(df), len(df) + future_periods)

future_df = pd.DataFrame({'time_index': future_index})
future_df['forecast_revenue'] = model.predict(future_df[['time_index']])

future_df['month'] = pd.date_range(
    start=df['month'].max() + pd.offsets.MonthBegin(1),
    periods=future_periods,
    freq='MS'
)

print("Future forecast:")
print(future_df)

# Plot actual vs forecast
plt.figure(figsize=(10, 5))
plt.plot(df['month'], df['monthly_revenue'], label='Actual Revenue')
plt.plot(
    future_df['month'],
    future_df['forecast_revenue'],
    linestyle='--',
    label='Forecasted Revenue'
)

plt.xlabel("Month")
plt.ylabel("Revenue")
plt.title("Revenue Forecast – Next 6 Months")
plt.legend()
plt.tight_layout()
plt.show()
