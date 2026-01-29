# 📡 FTTH Performance Analysis (BSD Cluster)

![Tools](https://img.shields.io/badge/Tools-Python%20|%20SQL%20|%20Tableau-blue) ![Status](https://img.shields.io/badge/Status-Completed-success)

## 📋 Executive Summary
Project ini mensimulasikan peran **Performance Analyst** untuk mengevaluasi kualitas jaringan Fiber To The Home (FTTH) di area BSD City. Menggunakan dataset **100.000 tiket** (Jan - Des 2025), analisis ini bertujuan untuk mengidentifikasi inefisiensi teknisi dan pola gangguan infrastruktur.

**Key Result:** Ditemukan bahwa **18% tiket melanggar SLA (4 Jam)**, didominasi oleh masalah *Fiber Cut* dan kinerja 2 teknisi spesifik yang membutuhkan pembinaan.

## 📊 Dashboard Preview
![FTTH Dashboard](dashboard/dashboard_full.png)
*(Visualisasi data operasional tahun 2025)*

## 💼 Business Problem & Goals
* **Problem:** Meningkatnya komplain pelanggan VIP akibat durasi perbaikan yang lama (>4 Jam) dan denda penalti Managed Service.
* **Objective:**
  1. Menurunkan MTTR (Mean Time To Repair) di bawah 4 jam.
  2. Mengidentifikasi teknisi dengan performa terendah untuk re-training.
  3. Mengoptimalkan jadwal shift berdasarkan Heatmap jam sibuk.

## 🛠️ Tech Stack
* **Python (Pandas):** Generating 100k dummy dataset dengan distribusi probabilitas (Weighted Randomness) untuk mensimulasikan skenario dunia nyata.
* **SQL (SQLite):** Melakukan agregasi data, perhitungan MTTR, dan filtering tiket *Breach*.
* **Tableau:** Membuat dashboard interaktif untuk monitoring operasional harian.

## 🔍 Key Insights (Data-Driven)
Berdasarkan analisis data historis 2025:

1.  **Technician Performance:**
    * Teknisi **Andi Wijaya** dan **Tono Sudirjo** memiliki rata-rata MTTR tertinggi (5.8 Jam), jauh melampaui target.
    * Rekomendasi: Melakukan *refresher training* teknik splicing dan manajemen waktu.

2.  **Root Cause Analysis:**
    * **Fiber Cut** adalah penyumbang durasi terlama (Avg 6.2 Jam), namun frekuensinya rendah.
    * **Konfigurasi Logic** memiliki volume tiket tertinggi. Sering terjadi keterlambatan penanganan pada jam 10:00 - 14:00 WIB.

3.  **Peak Hour Strategy:**
    * Heatmap menunjukkan lonjakan tiket signifikan pada **Senin & Selasa (09:00 - 11:00)**.
    * Rekomendasi: Menambah personil *standby* di Node-B pada jam tersebut.

## 🚀 How to Use
1.  Clone repository ini.
2.  Install library: `pip install -r requirements.txt`
3.  Jalankan script generator: `python scripts/data_generator.py`
4.  Gunakan file CSV yang dihasilkan untuk analisis lebih lanjut di Tableau/SQL.

---
*Disclaimer: Project ini adalah simulasi portofolio menggunakan dummy data.*
