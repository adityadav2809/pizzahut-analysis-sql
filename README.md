# 🍕 Pizza Sales Analysis - SQL Project

This project contains a comprehensive SQL script designed to analyze pizza sales data from a fictional `pizzahut` database. The script is structured to address a range of questions from basic metrics to advanced revenue analysis.

---

## 📁 Database Used

**Database Name:** `pizzahut`

This database includes the following main tables:

- `orders`: Contains order IDs, timestamps, and dates.
- `order_details`: Contains item-level order data (pizza ID, quantity).
- `pizzas`: Contains pizza IDs, sizes, prices, and links to types.
- `pizza_types`: Contains names and categories of pizzas.

---

## 🔍 What the Script Does

The SQL script is divided into three main sections:

### ✅ Basic Queries
- Total number of orders placed
- Total revenue generated from pizza sales
- Highest-priced pizza
- Most common pizza size ordered
- Top 5 most ordered pizza types

### 🔁 Intermediate Queries
- Total quantity of each pizza category ordered
- Order distribution by hour of the day
- Category-wise distribution of pizzas
- Average pizzas per day (grouped by date)
- Top 3 pizza types by revenue

### 🔥 Advanced Queries
- Percentage contribution of each pizza type to total revenue
- Cumulative revenue over time
- Top 3 most ordered pizza types by revenue **within each category**

---

## 🧠 Usage

To run the script:

1. Make sure you have a SQL environment (e.g., MySQL, PostgreSQL) with the `pizzahut` schema created.
2. Import your pizza data into the relevant tables: `orders`, `order_details`, `pizzas`, and `pizza_types`.
3. Execute the SQL script in your query editor or command-line SQL client.

---

## 📌 Author

Created by [Aditya Yadav](mailto:adityadav2809@gmail.com)

---

## 📜 License

This project is open-source and free to use for educational or commercial purposes. Attribution is appreciated.

---

## 🥂 Happy Querying!

Feel free to modify, expand, or integrate these queries into dashboards and BI tools for visualizations or deeper analytics!
