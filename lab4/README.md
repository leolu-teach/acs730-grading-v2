# Lab 4 - Docker Fundamentals

A small Flask app packaged as a Docker image.

- `app.py` / `requirements.txt` - the app.
- `Dockerfile` - builds a `python:3.11-slim`-based image, installs deps, runs the app on port 5000.
- `.dockerignore` - keeps `.git`/`__pycache__`/`.terraform` out of the build context.

Tested locally with `docker build -t acs730-lab4 .` and `docker run -p 5000:5000 acs730-lab4`.
