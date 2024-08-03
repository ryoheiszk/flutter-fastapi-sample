import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routers import timer
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Get environment variables
API_PORT = int(os.getenv("API_PORT", 8000))
DEBUG = os.getenv("DEBUG", "False").lower() in ("true", "1", "t")

app = FastAPI(
    title="Timer API",
    description="API for managing timer records",
    version="1.0.0",
    openapi_url="/api/openapi.json",
    docs_url="/api/docs",
    redoc_url="/api/redoc",
    debug=DEBUG
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(timer.router, prefix="/api")

@app.get("/api/")
async def root():
    return {"message": "Welcome to the Timer API"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=API_PORT)
