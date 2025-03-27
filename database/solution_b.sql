-- Câu 1: Liệt kê các hóa đơn của khách hàng
SELECT users.user_id, users.user_name, orders.order_id FROM users
JOIN orders ON users.user_id = orders.user_id;

-- Câu 2: Liệt kê số lượng các hóa đơn của khách hàng
SELECT users.user_id, users.user_name, COUNT(orders.order_id) AS so_hoa_don FROM users
JOIN orders ON users.user_id = orders.user_id
GROUP BY users.user_id, users.user_name;

-- Câu 3: Liệt kê thông tin hóa đơn
SELECT orders.order_id, COUNT(order_details.product_id) AS so_san_pham FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY orders.order_id;

-- Câu 4: Liệt kê thông tin mua hàng theo nhóm
SELECT users.user_id, users.user_name, orders.order_id, products.product_name FROM users
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
ORDER BY orders.order_id;

-- Câu 5: Liệt kê 7 người dùng có số lượng đơn hàng nhiều nhất
SELECT users.user_id, users.user_name, COUNT(orders.order_id) AS so_don_hang FROM users
JOIN orders ON users.user_id = orders.user_id
GROUP BY users.user_id, users.user_name
ORDER BY so_don_hang DESC
LIMIT 7;

-- Câu 6: Liệt kê 7 người dùng mua sản phẩm có tên Samsung hoặc Apple
SELECT DISTINCT users.user_id, users.user_name, orders.order_id, products.product_name FROM users
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
WHERE products.product_name LIKE '%Samsung%' OR products.product_name LIKE '%Apple%'
LIMIT 7;

-- Câu 7: Liệt kê danh sách mua hàng của user bao gồm tổng tiền của mỗi đơn hàng
SELECT users.user_id, users.user_name, orders.order_id, SUM(products.product_price) AS tong_tien FROM users
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
GROUP BY orders.order_id;

-- Câu 8: Liệt kê mỗi user với đơn hàng có giá trị lớn nhất
SELECT users.user_id, users.user_name, orders.order_id, MAX(tong_tien) FROM (
    SELECT users.user_id, users.user_name, orders.order_id, SUM(products.product_price) AS tong_tien FROM users
    JOIN orders ON users.user_id = orders.user_id
    JOIN order_details ON orders.order_id = order_details.order_id
    JOIN products ON order_details.product_id = products.product_id
    GROUP BY orders.order_id
) AS subquery
GROUP BY users.user_id;

-- Câu 9: Liệt kê mỗi user với đơn hàng có giá trị nhỏ nhất
SELECT users.user_id, users.user_name, orders.order_id, MIN(tong_tien) FROM (
    SELECT users.user_id, users.user_name, orders.order_id, SUM(products.product_price) AS tong_tien FROM users
    JOIN orders ON users.user_id = orders.user_id
    JOIN order_details ON orders.order_id = order_details.order_id
    JOIN products ON order_details.product_id = products.product_id
    GROUP BY orders.order_id
) AS subquery
GROUP BY users.user_id;

-- Câu 10: Liệt kê mỗi user với đơn hàng có số lượng sản phẩm nhiều nhất
SELECT users.user_id, users.user_name, orders.order_id, MAX(so_san_pham) FROM (
    SELECT users.user_id, users.user_name, orders.order_id, COUNT(order_details.product_id) AS so_san_pham FROM users
    JOIN orders ON users.user_id = orders.user_id
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_id
) AS subquery
GROUP BY users.user_id;
