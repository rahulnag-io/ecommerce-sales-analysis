# 🛒 E-Commerce Sales Analysis — Olist (Brazil)

A end-to-end data analysis project using **SQL + Python** on the [Brazilian E-Commerce dataset (Olist)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — 100k+ real orders across 2016–2018.

---

## 📌 Project Objective

Uncover actionable business insights from raw transactional data by:
- Writing multi-table SQL queries to extract key metrics
- Visualizing trends in Python (Jupyter Notebook)
- Framing findings as an executive-ready summary

---

## 📁 Project Structure

```
ecommerce-sales-analysis/
│
├── data/
│   └── raw/                        # Original CSVs from Kaggle (not committed)
│
├── sql/
│   ├── schema.sql                  # Table definitions (orders, payments, products, etc.)
│   └── queries.sql                 # 4 core analytical queries (revenue, categories,
│                                   # retention, delivery vs reviews)
│
├── notebooks/
│   └── analysis.ipynb              # Full EDA: SQL → Python → charts
│
├── src/
│   └── data_loader.py              # (Unused in final version) — MySQL connection setup
│                                   # Connection and query execution handled in notebook
│
├── outputs/
│   ├── charts/                     # PNG exports of all visualizations
│   │   └── monthly_revenue_trend.png
│   │
│   └── report.pdf                  # Executive insight report (3 key findings + recommendations)
│
└── README.md
```
---

## 🔍 Key Analyses

| # | Analysis | SQL Technique |
|---|----------|---------------|
| 1 | Monthly Revenue Trend | `DATE_FORMAT` + `GROUP BY` on timestamp |
| 2 | Best-Selling Categories | Multi-table `JOIN` + `COUNT` + `LIMIT` |
| 3 | Customer Retention Rate | `HAVING COUNT > 1` to flag repeat buyers |
| 4 | Delivery Time vs Review Score | `TIMESTAMPDIFF` + `AVG` grouped by score |

---

## 🗃️ Dataset

**Source:** [Kaggle — Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

**Key tables used:**

| Table | Description |
|-------|-------------|
| `orders` | Order lifecycle timestamps (purchase, approval, delivery) |
| `order_items` | Line items linking orders to products |
| `payments` | Payment values per order |
| `products` | Product metadata including category |
| `reviews` | Customer review scores (1–5) |

> ⚠️ Raw data files are not committed. Download from Kaggle and place CSVs in `data/raw/`.

---

## ⚙️ Setup & Usage

### 1. Clone the repo
```bash
git clone https://github.com/rahulnag-io/ecommerce-sales-analysis.git
cd ecommerce-sales-analysis
```

### 2. Install dependencies
```bash
pip install mysql-connector-python pandas matplotlib seaborn jupyter
```

### 3. Load data into MySQL
```bash
mysql -u root -p < sql/schema.sql
# Then import the CSVs via MySQL Workbench or LOAD DATA INFILE
```

### 4. Run the notebook
```bash
jupyter notebook notebooks/analysis.ipynb
```

> Database connection is configured directly inside the notebook using `mysql-connector-python`.

---

## 📊 Executive Summary (Top 3 Insights)

> Full narrative with charts is in `notebooks/analysis.ipynb` and `outputs/report.pdf`.

1. **Revenue peaked in Nov 2017 then declined** — likely driven by Black Friday/seasonal demand. The business should plan inventory and marketing campaigns around Q4 spikes.

2. **Top 3 categories (bed/bath/table, health/beauty, sports/leisure) drive ~30% of all orders** — these are the highest-leverage SKUs for promotional investment and stock prioritization.

3. **Faster delivery = dramatically better reviews** — orders delivered in ≤1 week average 4+ stars; orders taking 3+ weeks drop below 2.5 stars. Logistics optimization is the single biggest lever for customer satisfaction.

---

## 🛠️ Tech Stack

- **Database:** MySQL
- **Query Language:** SQL (MySQL dialect)
- **Analysis:** Python 3, pandas, matplotlib, seaborn
- **Notebook:** Jupyter
- **Reporting:** PDF (reportlab)

---

## 📄 License

This project is for portfolio/educational purposes. Dataset is public and provided by Olist via Kaggle.