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
