import requests
import time
import os

back_host = os.getenv("BACK_HOST", default="localhost")
url = "http://" + back_host + ":8000/statistics"
os.makedirs('/app/data', exist_ok=True)
output_file = "/app/data/statistics_log.txt"

def log_statistics():

    response = requests.get(url)
    response.raise_for_status()
    data = response.json()
    count = data.get("count", 0)

    with open(output_file, "a") as file:
        file.write(f"Count: {count}, Timestamp: {time.strftime('%Y-%m-%d %H:%M:%S')}\n")

    print(f"Logged count: {count}")


if __name__ == "__main__":
    while True:
        log_statistics()
        time.sleep(5)
