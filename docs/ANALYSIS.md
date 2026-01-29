# 📈 FTTH Performance Analysis Report

**Date:** January 2026  
**Author:** Maulana Firman Nurdiansyah  
**Context:** Analysis of 100,000 FTTH Incident Tickets (Jan–Dec 2025) – BSD Cluster  

---

## 1. Executive Summary

Berdasarkan analisis data historis tahun 2025, operasional layanan FTTH di area BSD menghadapi tantangan utama pada kepatuhan **Service Level Agreement (SLA)**.

Temuan utama menunjukkan bahwa:
- Tingkat kegagalan SLA (*SLA Breach Rate*) mencapai **hingga 18% pada teknisi tertentu**
- Gangguan infrastruktur fisik, khususnya **Fiber Cut**, menjadi penyebab utama durasi perbaikan terpanjang

Laporan ini menyajikan analisis mendalam berdasarkan **kinerja teknisi**, **akar penyebab gangguan**, dan **pola waktu operasional**, serta diakhiri dengan rekomendasi strategis berbasis data.

---

## 2. Technician Performance Scorecard

**Objective:**  
Mengidentifikasi teknisi dengan performa di bawah standar untuk prioritas pelatihan dan redistribusi tugas.

### 🔍 SQL Query Analysis

Query berikut digunakan untuk menghitung:
- Total tiket per teknisi
- Rata-rata MTTR (*Mean Time To Repair*)
- Jumlah dan persentase pelanggaran SLA

```sql
SELECT 
    Technician,
    COUNT(Ticket_ID) AS Total_Job,
    ROUND(AVG(Duration_Hours), 2) AS Avg_MTTR,
    SUM(CASE WHEN SLA_Flag = 'Breach' THEN 1 ELSE 0 END) AS Total_Breach,
    ROUND(
        CAST(SUM(CASE WHEN SLA_Flag = 'Breach' THEN 1 ELSE 0 END) AS FLOAT) 
        / COUNT(Ticket_ID) * 100, 
    1) || '%' AS Breach_Rate
FROM ftth_tickets
GROUP BY Technician
ORDER BY Avg_MTTR DESC
LIMIT 5;

---

## 📊 Bottom 5 Technician Performance

| Technician        | Total Job | Avg MTTR (Hours) | Total Breach | Breach Rate |
|-------------------|-----------|------------------|--------------|-------------|
| Andi Wijaya       | 5,014     | 2.49             | 913          | 18.2%       |
| Tono Sudirjo      | 5,116     | 2.34             | 843          | 16.5%       |
| Joko Anwar        | 4,983     | 2.17             | 702          | 14.1%       |
| Oki Setiana       | 4,914     | 2.02             | 626          | 12.7%       |
| Gilang Ramadhan   | 4,917     | 1.98             | 541          | 11.0%       |

### 💡 Key Insights

- **Andi Wijaya** dan **Tono Sudirjo** memiliki tingkat pelanggaran SLA jauh di atas rata-rata tim (>15%).
- Distribusi beban kerja relatif merata (±5.000 tiket per teknisi), sehingga akar masalah **bukan volume pekerjaan**, melainkan **efisiensi dan skill individu**.

---

## 🔍 Root Cause Analysis

### Objective  
Mengidentifikasi jenis gangguan yang paling berdampak terhadap kegagalan SLA.

### SQL Query Analysis

```sql
SELECT 
    Root_Cause,
    COUNT(Ticket_ID) AS Frequency,
    ROUND(AVG(Duration_Hours), 2) AS Avg_Duration,
    SUM(CASE WHEN SLA_Flag = 'Breach' THEN 1 ELSE 0 END) AS SLA_Breach_Count
FROM ftth_tickets
GROUP BY Root_Cause
ORDER BY Avg_Duration DESC;

---


