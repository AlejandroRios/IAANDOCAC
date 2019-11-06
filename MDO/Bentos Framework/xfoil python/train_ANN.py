from sklearn.neural_network import MLPClassifier
import pandas as pd

df = pd.read_csv('Clmax.csv', header=None, delimiter=',')

print(df)