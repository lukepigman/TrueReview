from textblob import TextBlob
import pickle
import math
import http
import json

cl = pickle.load(open('sentiment_classifier.obj', 'rb'))

def getSentiment(textArray):
    scores = []
    for item in textArray:
        blob = TextBlob(item, classifier = cl)
        print(item)
        scores.append(blob.sentiment)
    return calculateTR(scores)

def calculateTR(scores):
    scoreList = []
    total = 0.0
    for item in scores:
        scoreList.append(item.polarity)
        print(item.polarity)
    
    for score in scoreList:
        total = total + score
        
    
    print(total)
    avg = ((total / len(scoreList)) * 100)
    out = round(avg, 2)
    output = {
       "Score" : out
    }
    
    return output



