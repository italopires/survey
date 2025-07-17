# README

# Introduction

Survey is an application that allow use to build awesome surveys into the companys, to help the managers to ask key questions in order to improve workflows, bring enhancements for the teams and company.

### Ruby on Rails
This application requires:
* ruby 3.4.3

### Database
This application uses Postgresql with ActiveRecord

### Development
* Testing Framework: RSpec and Factory Bot

## Build, Import CSV file and Up Docker container.

```console
docker-compose build
docker-compose run web rails db:create db:migrate survey:csv_import
docker-compose up
```
## Deploy local through RVM and Ruby
```
rvm install 3.4.3
```
Learn more about [RVM](https://rvm.io/rvm/install) installation

### Install dependencies
Using [Bundler](https://github.com/bundler/bundler)
```
gem install bundler
bundle
```
### Task for initial development setup

```
rails db:create
rails db:migrate
```
### Start rails server
```
rails s -b 0.0.0.0 -p 3000
```
### To run the tests, execute the command bellow
```
rspec
```

## Task Checklist

Select the tasks you wish to complete by marking them with an `X` in the `[ ]` brackets.

### **My Selected Tasks**

- [X] **Task 1**: Create a Basic Database
- [ ] **Task 2**: Create a Basic Dashboard
- [X] **Task 3**: Create a Test Suite
- [X] **Task 4**: Create a Docker Compose Setup
- [ ] **Task 5**: Exploratory Data Analysis
- [ ] **Task 6**: Data Visualization - Company Level
- [ ] **Task 7**: Data Visualization - Area Level
- [ ] **Task 8**: Data Visualization - Employee Level
- [X] **Task 9**: Build a Simple API
- [X] **Task 10**: Sentiment Analysis
- [ ] **Task 11**: Report Generation
- [ ] **Task 12**: Creative Exploration

## 🧠 Task 10: Sentiment Analysis

This project integrates a sentiment analysis microservice to process employee feedback comments.

### ✅ Requirements fulfilled:
- Text preprocessing using spaCy (`pt_core_news_sm`): tokenization and stop-word removal.
- Sentiment analysis for Portuguese using a transformer-based model.
- Summary of overall sentiment with representative examples.

### 🔍 How it works:
- A Flask API runs on `localhost:5001` exposing `POST /analyze`, located at `sentiment_api/sentiment_api.py`, which returns the sentiment of a single comment.
- The **spaCy** library is used inside the API to preprocess text in Portuguese, including tokenization and removal of stop words.
- The Rails app uses a service (`FeelingAnalysisService`) and the `httparty` gem to send comments in batch.
- The API responses are grouped and summarized into totals and examples.

### 📊 Sample Output:
```json
{
  "summary": {
    "total": 4000,
    "positive": 226,
    "negative": 13,
    "neutral": 3761
  },
  "examples": {
    "positive": [
      "A empresa tem um excelente ambiente de trabalho e equipe colaborativa.",
      "Os benefícios oferecidos são bons, mas poderiam ser mais diversificados.",
      "Estou satisfeito com a cultura da empresa e como valorizam os funcionários."
    ],
    "negative": [
      "A carga de trabalho às vezes é excessiva e causa estresse.",
      "Sinto que há poucas oportunidades de avanço na minha carreira atual.",
      "Sinto que há poucas oportunidades de promoção."
    ],
    "neutral": ["-", "-", "-"]
  }
}

### 📄 API Documentation

You can explore and test the Sentiment Analysis API via Postman at the following link:  
👉 [API Documentation on Postman](https://documenter.getpostman.com/view/34024629/2sB34ikzaC)
