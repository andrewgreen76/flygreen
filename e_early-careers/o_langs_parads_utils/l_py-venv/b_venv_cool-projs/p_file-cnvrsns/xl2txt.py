import pandas as pd

sht1d = pd.read_excel('sample.xlsx', sheet_name=0)
sht2d = pd.read_excel('sample.xlsx', sheet_name="Sales")

print(sht1d)
print(sht2d)

