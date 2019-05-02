from yelpapi import YelpAPI
import TRApp.utils.sentiment as sentiment
import json

def process(id):
    yp = YelpAPI('zmd9y3Q30Zj7Ekoh8sokT1bmzw4hWXNfzpjbnjSV5GXhX6v6gKslsx7T645Dm4rBMCv-x5ZKAM_0l7-FlFJS76ev43IWXnDcwyoOwIRVZh2SGyLne_jzL3-LHAbGXHYx')
    response = yp.reviews_query(id)
    textArray = []
    for item in response['reviews']:
        textArray.append(item['text'])



    return str(sentiment.getSentiment(textArray))


