from fastapi import FastAPI
import uvicorn
from mylib.logic import wiki, search_wiki, phrase

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Wikipedia API. Call /search or /wiki"}


@app.get("/search/{value}")
async def search(value: str):
    """search for wikipedia"""

    results = search_wiki(value)
    return {"total": results}


@app.get("/wiki/{name}")
async def get_wiki(name: str):
    """retrieve wiki page"""

    results = wiki(name)
    return {"total": results}


@app.get("/phrase/{name}")
async def phrase_wiki(name: str):
    """retrieve wiki page and phrase it"""

    results = phrase(name)
    return {"total": results}


if __name__ == "__main__":
    uvicorn.run(app, port=8080, host="0.0.0.0")
