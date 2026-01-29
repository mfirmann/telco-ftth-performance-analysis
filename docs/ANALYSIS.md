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
```
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
```
---

## 📊 Root Cause Breakdown

| Root Cause | Frequency | Avg Duration (Hours) | SLA Breach Count |
| :--- | :--- | :--- | :--- |
| **Fiber Cut (Kabel Putus)** | 5,040 | **5.72** | 4,148 |
| Gangguan Tiang/Kabel | 14,945 | 3.35 | 3,992 |
| Redaman Tinggi | 25,048 | 1.91 | 305 |
| ONT / Modem Rusak | 20,082 | 1.20 | 0 |
| Konfigurasi Logic | 34,885 | 0.58 | 0 |

### 💡 Key Insights
* **Fiber Cut** merupakan gangguan paling kritis:
    * Rata-rata durasi **5.72 jam**.
    * Hampir mustahil memenuhi **SLA 4 jam** tanpa perubahan proses.
* **Konfigurasi Logic** memiliki volume tertinggi namun **tidak menyebabkan pelanggaran SLA**, menunjukkan kategori **High Volume – Low Severity**.

---

## ⏰ Peak Hour & Shift Analysis

### Objective
Menentukan jam operasional tersibuk untuk optimalisasi penjadwalan teknisi.

### SQL Query Analysis
```sql
SELECT 
    strftime('%H', Open_Time) AS Hour,
    COUNT(Ticket_ID) AS Volume,
    ROUND(AVG(Duration_Hours), 2) AS Avg_MTTR
FROM ftth_tickets
GROUP BY Hour
ORDER BY Volume DESC
LIMIT 5;
```
### 📊 Top 5 Peak Hours

| Hour (WIB) | Ticket Volume | Avg MTTR |
| :--- | :--- | :--- |
| **13:00** | 8,091 | 1.69 |
| 08:00 | 8,091 | 1.71 |
| 10:00 | 7,999 | 1.72 |
| 15:00 | 7,969 | 1.71 |
| 09:00 | 7,965 | 1.72 |

### 💡 Key Insights
* Beban tiket tinggi secara konsisten pada **08:00 – 16:00 WIB**.
* Tidak terjadi penurunan volume saat jam makan siang.
* **Lonjakan kembali terjadi pada pukul 13:00 WIB.**

---

## 🚀 Strategic Recommendations

Berdasarkan hasil analisis, direkomendasikan tiga langkah strategis berikut:

### 1️⃣ Skill-Based Pairing (Mentorship Program)
Terapkan sistem tandem antara teknisi dengan Breach Rate >10% dan Top Performer.
* **Fokus awal pada teknisi:** Andi Wijaya & Tono Sudirjo.
* **Action:** Batasi penugasan tiket *Fiber Cut* kepada teknisi dengan performa SLA rendah hingga MTTR stabil.

### 2️⃣ Infrastructure Vendor Audit
Durasi *Fiber Cut* melebihi SLA secara sistemik. Tindakan yang disarankan:
* Audit vendor sipil / splicing.
* Negosiasi ulang *response time* dan SLA pihak ketiga.

### 3️⃣ Staggered Shift Implementation
Ubah skema kerja dari *single shift* menjadi:
* **Shift A:** 07:00 – 15:00 (Persiapan & beban pagi).
* **Shift B:** 10:00 – 19:00 (Backup jam puncak siang & sore).

*Pendekatan ini memastikan ketersediaan teknisi maksimal pada jam kritis 10:00 – 15:00 WIB.*
