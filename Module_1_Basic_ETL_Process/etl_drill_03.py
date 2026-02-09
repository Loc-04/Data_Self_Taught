import pandas as pd
import json
import etl_drill_01 as drill01
#redo the question in 02 but now using panda, not by doing it manually

#Bước 1, dùng pd để đọc dữ liệu và lưu vào biến
f_source = pd.read_json('data_source.json')

#Bước 2, phải làm sạch dữ liệu trước khi cal
f_source['amount'] = pd.to_numeric(f_source['amount'], errors = 'coerce').fillna(0)
#có error để chuyển lỗi thành rỗng, tránh việc pandas ngừng khi gặp lỗi
#fillna chuyển mấy chỗ NaN thành 0

#Bước 3, thay vì dùng cách gọi hàm thì dùng thẳng groupby sum để tính
f_result = f_source.groupby('category')['amount'].sum()

#Bước 4, lưu vào file mới
f_result.to_json('report.json', indent=4)
