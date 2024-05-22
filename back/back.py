from fastapi import FastAPI
from datetime import datetime
from pydantic import BaseModel
import requests

app = FastAPI()

time_request_count = 0

class StatisticsResponse(BaseModel):
    count: int

@app.get("/time")
async def get_time():
    global time_request_count
    time_request_count += 1
    request = requests.get('http://worldtimeapi.org/api/timezone/Europe/Moscow')
    if request.status_code == 200:
        return request.json()['datetime']
    return 'error'

@app.get("/statistics", response_model=StatisticsResponse)
async def get_statistics():
    return {"count": time_request_count}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)