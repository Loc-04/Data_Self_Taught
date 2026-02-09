import pandas as pd

#Bước 1 : Đọc file csv
#Bước 2: Lọc category có amount > 500
#Bước 3: Lưu vào file filtered_report.csv gồm cột category và total

df = pd.read_csv('data.csv')

df['amount'] = pd.to_numeric(df['amount'], errors = 'coerce').fillna(0)

df_sum = df.groupby('category')['amount'].sum()

df_result = df_sum[df_sum > 500].reset_index()

file_path = 'filtered_report.csv'

df_result.to_csv(file_path, index = False)
