FROM python:3.9-buster as builder

ENV PYTHONUNBUFFERED=1

RUN mkdir app

WORKDIR /app

COPY Pipfile.lock /app/

RUN pip install -U pip && \
    pip install pipenv==2021.5.29 && \
    pipenv sync --system && \
    pip uninstall --yes pipenv

FROM python:3.9-slim-buster as production

ENV PYTHONUNBUFFERED=1

RUN mkdir app

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages/
COPY --from=builder /app /app/