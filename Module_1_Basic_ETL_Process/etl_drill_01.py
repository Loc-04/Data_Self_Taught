from typing import List, Dict, Any

transactions = [
    {"id": 101, "amount": 500, "category": "Electronics"},
    {"id": 102, "amount": 200, "category": "Grocery"},
    {"id": 103, "amount": 150, "category": "Electronics"},
    {"id": 104, "amount": 50, "category": "Grocery"},
    {"id": 105, "amount": 900, "category": "Furniture"}
]

#Input Một list chứa các dictionary. Mỗi dictionary đại diện cho 1 transaction
#Viết một hàm (Function) bằng Pure Python (Không import Pandas, Numpy) để tính tổng doanh thu (total amount) theo từng category.
#Ouput loại hàng và số lượng
#Constraint : phải có TypeHinting (ex : typing.List), Docstring

def calculate_total_by_category(transactions: List[Dict[str, Any]]) -> Dict[str, int]:
    """
    Ghi chú giải thích, k phải là comment
    Sử dụng dict.get để yêu cầu lấy key ra và cộng dồn value, nếu không có thì tạo 1 cái mới để lưu
    Luồng hoạt động : ví dụ nếu có transaction là electronic 500, thì lần loop tiếp theo nếu có sẽ cộng dồn
    Thêm logic để error handling, ví dụ amount bị thành string thì cố gắng ép kiểu về int, ép trước thành float rồi mới thành int để chắc chắn
    """
    result_agg: dict[str, int] = {}
    err:str ="Lỗi dữ liệu"
    for transaction in transactions:
        #Bước 1 : Bảo vệ giai đoạn extract dữ liệu
        #Dùng dict.get để lọc dữ liệu đầu vào trước khi làm gì
        category = transaction.get("category") or "Unknown" #Lấy value, thiếu thì bỏ unknown
        raw_amount = transaction.get("amount") #Lấy value

        #Bước 2 : Làm sạch dữ liệu aka Sanitization, thực hiện logic ép kiểu ở đây
        clean_amount = 0
        try :
            #Cách giải quyết, ép về float, ép về int xử lí
            #Nếu raw_amount là None thì sẽ trả về TypeError, abc thì sẽ là ValueError, tất cả sẽ xuống except
            clean_amount = int(float(raw_amount)) #type:ignore
        except (ValueError, TypeError):
            # LOGGING: Trong thực tế đoạn này dùng thư viện logger, không print
            print(f"[WARN] Skipping bad data. ID: {transaction.get('id', 'N/A')} - Amount: {raw_amount}")
            continue # Skip record này

        #Bước 3 : sau khi clean data thì cộng vô
        result_agg[category] = result_agg.get(category, 0) + clean_amount
    return result_agg