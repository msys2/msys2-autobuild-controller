FROM python:3.13-bookworm

RUN python -m pip install "uv==0.9.5"

COPY . /app
WORKDIR /app

RUN uv sync --locked --no-dev --compile-bytecode

ENTRYPOINT ["uv", "run", "--no-sync", "gunicorn", "--threads", "4", "-w", "1", "--access-logfile", "-", "--bind", "0.0.0.0:80", "flask_app:app"]

EXPOSE 80
