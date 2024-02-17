import joblib
from fastapi import FastAPI
from pydantic import BaseModel
import pandas as pd
# models
class Data(BaseModel):
    area: float
    bedrooms:int
    bathrooms:int
    balcony:int
    parking:int
    lift:int
    new_property:bool
    flat:bool

class PredictionResponse(BaseModel):
    accuracy:float = 0.7320722205142588
    expected_price: float

# Work with trained model
class PredictionModel:
    def __init__(self) -> None:
        self.model = joblib.load("../models/price_prediction_model.joblib")

        self.df = pd.read_csv('../data/dataset.csv')
       
    def predict(self, data: Data):
        return round(self.model.predict([[
            data.area,
            data.bedrooms,
            data.bathrooms,
            data.balcony,
            data.parking,
            data.lift,
            data.new_property,
            data.flat
           ]])[0],2)
    
        

# api 
app = FastAPI()

@app.post('/api/predict')
def predict(data:Data):
    return PredictionResponse(expected_price=PredictionModel().predict(data)) 
