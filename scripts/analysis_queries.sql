-- Memastikan ada 100.000 baris dan kolom terbaca benar
SELECT COUNT(*) AS Total_Rows FROM ftth_tickets;

-- Cek Tipe Data (Preview)
SELECT * FROM ftth_tickets LIMIT 5;

-- 1. Query: Rapor Teknisi (MTTR & SLA Breach)
SELECT 
    Technician,
    -- Berapa banyak tiket yang dia kerjakan?
    COUNT(Ticket_ID) AS Total_Job,
    
    -- Rata-rata waktu pengerjaan (MTTR) - Dibulatkan 2 desimal
    ROUND(AVG(Duration_Hours), 2) AS Avg_MTTR_Hours,
    
    -- Berapa tiket yang jebol target (> 4 Jam)?
    SUM(CASE WHEN SLA_Flag = 'Breach' THEN 1 ELSE 0 END) AS Total_Breach,
    
    -- Persentase kegagalan (Breach Rate)
    ROUND(CAST(SUM(CASE WHEN SLA_Flag = 'Breach' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(Ticket_ID) * 100, 1) || '%' AS Breach_Rate
FROM 
    ftth_tickets
GROUP BY 
    Technician
ORDER BY 
    Avg_MTTR_Hours DESC; -- Urutkan dari yang paling lambat

-- 2. Query: Masalah Paling Sering vs Paling Lama
SELECT 
    Root_Cause,
    -- Seberapa sering masalah ini muncul? (Volume)
    COUNT(Ticket_ID) AS Frequency,
    
    -- Seberapa lama rata-rata perbaikannya? (Impact)
    ROUND(AVG(Duration_Hours), 2) AS Avg_Duration_Hours,
    
    -- Kontribusi terhadap Breach
    SUM(CASE WHEN SLA_Flag = 'Breach' THEN 1 ELSE 0 END) AS Total_Breach_Tickets
FROM 
    ftth_tickets
GROUP BY 
    Root_Cause
ORDER BY 
    Avg_Duration_Hours DESC;
	
-- 3. Query: Jam Sibuk (Peak Hour Analysis)
SELECT 
    -- Ambil jam saja dari tanggal (Syntax SQLite)
    strftime('%H', Open_Time) AS Jam_Sibuk,
    COUNT(Ticket_ID) AS Jumlah_Tiket,
    ROUND(AVG(Duration_Hours), 2) AS Avg_MTTR
FROM 
    ftth_tickets
GROUP BY 
    Jam_Sibuk
ORDER BY 
    Jumlah_Tiket DESC;