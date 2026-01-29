# 📘 Data Dictionary

Dokumen ini menjelaskan struktur dan definisi kolom pada dataset  
**`ftth_bsd_100k_full.csv`** yang digunakan dalam analisis performa FTTH.

---

## Dataset Overview

- **Total Records:** 100,000
- **Periode Data:** Januari – Desember 2025
- **Tipe Data:** Synthetic / Simulated Operational Data
- **Tujuan:** Analisis SLA, MTTR, dan performa teknisi

---

## Column Definitions

| Column Name | Data Type | Description | Example |
|------------|----------|-------------|---------|
| `Ticket_ID` | String | Identitas unik tiket gangguan (Incident Number). | `INC-202500001` |
| `Technician` | String | Nama teknisi lapangan yang menangani tiket. | `Budi Santoso` |
| `Region` | String | Kluster area gangguan di BSD City. | `BSD_Sektor_1` |
| `Customer_Type` | String | Segmen pelanggan yang memengaruhi prioritas SLA. | `VIP`, `Regular` |
| `Root_Cause` | String | Akar penyebab teknis gangguan layanan. | `Fiber Cut` |
| `Open_Time` | Datetime | Waktu tiket dibuat (pelanggan melapor). | `2025-01-01 08:30:00` |
| `Close_Time` | Datetime | Waktu tiket ditutup (layanan normal). | `2025-01-01 10:30:00` |
| `Duration_Hours` | Float | Durasi perbaikan (jam). | `2.5` |
| `SLA_Flag` | String | Status kepatuhan SLA (Target: 4 Jam). | `Comply`, `Breach` |

---

## Dataset Notes

- Dataset ini **bukan data produksi**, melainkan data sintetis.
- Distribusi data dirancang menyerupai kondisi operasional FTTH nyata:
  - Jam sibuk
  - Variasi skill teknisi
  - Dominasi gangguan tertentu (Fiber Cut)
- Cocok digunakan untuk:
  - SQL Analysis
  - Dashboard BI
  - SLA Monitoring Simulation

---
