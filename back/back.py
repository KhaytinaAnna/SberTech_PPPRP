from fastapi import FastAPI
from datetime import datetime
from pydantic import BaseModel

app = FastAPI()

time_request_count = 0

class StatisticsResponse(BaseModel):
    count: int

@app.get("/time")
async def get_time():
    global time_request_count
    time_request_count += 1
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    return {"current_time": current_time}

@app.get("/statistics", response_model=StatisticsResponse)
async def get_statistics():
    return {"count": time_request_count}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)