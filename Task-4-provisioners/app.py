from fastapi import FastAPI
from fastapi.responses import PlainTextResponse

app = FastAPI()

@app.get('/', response_class=PlainTextResponse)
def hello():
    return 'Hello, Terraform Provisioners!'

# To run: uvicorn <filename>:app --host 0.0.0.0 --port 8000