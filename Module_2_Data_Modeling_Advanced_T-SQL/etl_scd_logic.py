#Logic xử lý SCD Type 2 bằng Python

#Bước 1 : Lấy thông tin hiện tại

#Bước 2 : So sánh với dữ liệu cũ (vdu trước khi đổi vị trí), no change skip, có thì b3

#Bước 3 : SCD Type 2 Execution (Transaction):
#   Update trạng thái cũ từ 1 về 0, dùng hàm getdate để update ngày hết hạn
#   Thêm dòng mới, đặt ngày hạn mới bằng getdate

import pandas as pd
from sqlalchemy import create_engine

SERVER = 'localhost'
DATABASE = 'Module_2'
DRIVER = 'ODBC Driver 17 for SQL Server'
connection_string = f'mssql+pyodbc://@{SERVER}/{DATABASE}?driver={DRIVER}&trusted_connection=yes'
engine = create_engine(connection_string)

# 39888d39-b239-4d4a-a511-27cd46576cec id mẫu
id = '39888d39-b239-4d4a-a511-27cd46576cec'

from sqlalchemy import create_engine, text

def process_scd_type_2(engine, new_data):
    # 1. Check existing
    sql = f"SELECT * FROM Dim_Customer WHERE Customer_Source_ID = '{new_data['id']}' AND Is_Current = 1"
    current_record = pd.read_sql(sql, engine)

    if current_record.empty:
        # New Customer -> Insert Type 1
        sql_insert = f"""INSERT INTO Dim_Customer(Customer_Source_Id, Customer_Name, City, Phone, Valid_From, Valid_To, Is_Current)
                         VALUES('{new_data['id']}', '{new_data['name']}', '{new_data['city']}', '{new_data['phone']}',
                                GETDATE(), '9999-12-31', 1)"""
        with engine.begin() as conn:
            conn.execute(text(sql_insert))
        print("Inserted new customer")
    else:
        # Existing Customer -> Check for changes
        old_city = current_record.iloc[0]['City']
        if old_city != new_data['city']:
            print(f"Detect Change: {old_city} -> {new_data['city']}")

            # 2. Expire Old Record (UPDATE SQL)
            old_key = current_record.iloc[0]['Customer_Key']
            sql_update = f"UPDATE Dim_Customer SET Is_Current = 0, Valid_To = GETDATE() WHERE Customer_Key = {old_key}"

            # 3. Insert New Record (INSERT SQL)
            sql_insert = f"""INSERT INTO Dim_Customer(Customer_Source_Id, Customer_Name, City, Phone, Valid_From, Valid_To, Is_Current)
                             VALUES('{new_data['id']}', '{new_data['name']}', '{new_data['city']}', '{new_data['phone']}',
                                    GETDATE(), '9999-12-31', 1)"""

            # Transaction: Update + Insert cùng lúc
            with engine.begin() as conn:
                conn.execute(text(sql_update))
                conn.execute(text(sql_insert))
            print("SCD Type 2 executed")


# ========== TEST SCD TYPE 2 ==========
if __name__ == "__main__":
    # Dữ liệu mẫu: Mô phỏng Christina Webb đã đổi City
    # Old City (trong SSMS): 'Kingside'
    # New City (giả lập): 'Man United'
    new_data = {
        'id': '39888d39-b239-4d4a-a511-27cd46576cec',
        'name': 'Christina Webb',
        'city': 'Man United',      # ĐỔI từ Kingside → Man United
        'phone': '443-859-1446'
    }

    print("========== Bắt đầu xử lý SCD Type 2 ==========")
    process_scd_type_2(engine, new_data)

