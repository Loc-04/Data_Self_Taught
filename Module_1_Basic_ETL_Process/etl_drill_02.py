import etl_drill_01 as drill_1
import json

'''
Docstring for etl_drill_02

Dùng thư viện json để đọc file data_source.json vào biến transactions
Tái sử dụng hàm calculate_total_by_category qua cash import từ file 01, đây gọi là modularization
Ghi kết quả ra 1 file mới là report.json
Dùng with open vì nó giúp ta đóng/mở file ngay khi sử dụng xong, bớt tốn bộ nhớ không đáng có
indent để format file json đầu ra đẹp hơn, tiêu chuẩn thì là 4
'''
# Bước 1 : Đọc file data_source.json vào biến transactions bằng cách sử dụng open with với json.load
with open('data_source.json', 'r') as f_source:
    transactions = json.load(f_source)

#Bước 2 : tái sử dụng hàm ở file drill01
summary_report = drill_1.calculate_total_by_category(transactions)

#Bước 3 : viết dữ liệu sau xử lí qua hàm vào 1 file json mới
with open('report.json', 'w') as f_dest:
    json.dump(summary_report,f_dest, indent = 4)