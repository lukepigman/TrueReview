from textblob import TextBlob
from textblob.classifiers import NaiveBayesClassifier
from textblob.sentiments import NaiveBayesAnalyzer
from textblob import Blobber

import pandas as pd
import seaborn as sns
import pickle
#read the file
data = pd.read_csv("sts_gold_tweet.csv", sep=";", encoding="utf-8")

# replace 4 with 'post' and 0 as 'neg' in 'polarity' column
data['polarity'] = data.replace({4: 'poss', 0: 'neg'})

# convert the data into a list
data = list(data[['polarity', 'tweet']].values)

L = len(data)
train_index = int(0.60 * L)

# split the data into a train and test data
train = data[:train_index]

cl = NaiveBayesClassifier(train)


pickled_classifier_file = open('sentiment_classifier.obj', 'wb')
pickle.dump(cl, pickled_classifier_file)
pickled_classifier_file.close()