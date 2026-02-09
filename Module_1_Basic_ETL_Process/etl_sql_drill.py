#Kết nối vào database (giả lập sql qua sql lite)
#tạo banrgTranssactions và insert dummy data (dùng python để chạy sql)


import sqlite3
import pandas as pd

# 1. SETUP DATABASE (Giả lập môi trường)
conn = sqlite3.connect('company_data.db')
cursor = conn.cursor()

# Tạo bảng
cursor.execute('''
    CREATE TABLE IF NOT EXISTS Transactions (
        id INTEGER PRIMARY KEY,
        category TEXT,
        amount TEXT, -- Lưu text để giả lập data bẩn
        date TEXT
    )
''')

# Insert data mẫu (Có data bẩn)
sample_data = [
    (1, 'Electronics', '1200.50', '2023-01-01'),
    (2, 'Grocery', '50.00', '2023-01-02'),
    (3, 'Electronics', 'abc', '2023-01-03'), # Data bẩn
    (4, 'Furniture', '300', '2023-01-04')
]
cursor.executemany('INSERT OR IGNORE INTO Transactions VALUES (?, ?, ?, ?)', sample_data)
conn.commit()

print("--- Data Ingested to SQL ---")

# 2. PANDAS READ FROM SQL
# Query: Lấy toàn bộ data từ bảng Transactions
# Keyword: pd.read_sql

#Viết 1 lệnh sql ở đây để lấy data từ bảng Transactions
sql_query = "SELECT category, amount FROM Transactions"
df = pd.read_sql(sql_query, conn)

# 3. TRANSFORM (Logic cũ của em)
# ... Viết lại logic clean & aggregate ...
# Result mong muốn: DataFrame có cột [category, total_amount]

df['amount'] = pd.to_numeric(df['amount'], errors = 'coerce').fillna(0)

df_sum = df.groupby('category')['amount'].sum().reset_index(name='total_amount')
df_result = df_sum[df_sum['total_amount'] > 500].reset_index()

# 4. WRITE BACK TO SQL
# Lưu vào bảng mới tên 'Report_Category'
# Keyword: to_sql, if_exists='replace'
# ...

df_result.to_sql(name ='Report_Category', con = conn)

print("--- ETL Completed. Data saved to table Report_Category ---")

# Verify kết quả
print(pd.read_sql("SELECT * FROM Report_Category", conn))

conn.close()