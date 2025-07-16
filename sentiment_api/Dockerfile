FROM python:3.10-slim

WORKDIR /app

# Install spaCy dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    libjpeg-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# pt-BR spaCy model
RUN python -m spacy download pt_core_news_sm

COPY . .

EXPOSE 5001

CMD ["python", "sentiment_api.py"]
