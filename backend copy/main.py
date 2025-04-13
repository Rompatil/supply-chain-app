
from fastapi import FastAPI, HTTPException
import pandas as pd
import numpy as np
from statsmodels.tsa.arima.model import ARIMA

app = FastAPI()

sales_df = pd.read_csv("data/sales.csv")
inventory_df = pd.read_csv("data/inventory.csv")

@app.get("/")
def root():
    return {"message": "Dynamic AI Supply Chain Backend is live!"}

@app.get("/forecast-csv")
def forecast_from_csv(product: str, city: str, days: int = 10):
    df = sales_df[(sales_df['product_id'] == product) & (sales_df['city'] == city)]
    ts = df.groupby('date')['quantity'].sum().sort_index()
    if len(ts) < 3:
        return {
            "warning": "Not enough data for forecasting",
            "forecast": [0.0] * days
        }
    model = ARIMA(ts, order=(5, 1, 0)).fit()
    forecast = model.forecast(steps=days)
    return {"forecast": forecast.tolist()}

@app.get("/restock-csv")
def restock_from_inventory(product: str, city: str):
    df = inventory_df[(inventory_df['product_id'] == product) & (inventory_df['city'] == city)]
    if df.empty:
        raise HTTPException(status_code=404, detail="No inventory data found.")
    stock = df['closing_stock'].iloc[-1]
    next_demand = df['quantity_sold'].iloc[-1]
    action = 0
    if stock < 200:
        action = 1000
    elif stock < next_demand:
        action = 500
    return {
        "product": product,
        "city": city,
        "current_stock": int(stock),
        "predicted_demand": int(next_demand),
        "recommended_restock": action
    }

@app.get("/sales")
def get_sales():
    return sales_df.to_dict(orient="records")

@app.get("/inventory")
def get_inventory():
    return inventory_df.to_dict(orient="records")

@app.get("/dashboard-data")
def get_dashboard_data():
    forecast = sales_df.groupby('date')['quantity'].sum().sort_index()
    if len(forecast) > 5:
        forecast_model = ARIMA(forecast, order=(5, 1, 0)).fit()
        forecast_vals = forecast_model.forecast(steps=5).tolist()
    else:
        forecast_vals = forecast.tail(5).tolist()

    sales_summary = sales_df.groupby("product_id")["sales_value"].sum().reset_index()
    inventory_latest = inventory_df.sort_values("date").groupby("product_id").last().reset_index()

    return {
        "forecast": forecast_vals,
        "sales_summary": sales_summary.to_dict(orient="records"),
        "latest_inventory": inventory_latest.to_dict(orient="records")
    }
