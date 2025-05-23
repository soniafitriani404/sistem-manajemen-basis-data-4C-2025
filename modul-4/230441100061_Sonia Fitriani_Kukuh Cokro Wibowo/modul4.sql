USE `rental_sepeda_motor`;
-- No 1.
ALTER TABLE Motor ADD COLUMN Keterangan VARCHAR(100) AFTER STATUS;
-- Contoh update data:
UPDATE Motor SET Keterangan = 'Motor baru siap pakai' WHERE ID_Motor = 1;
UPDATE Motor SET Keterangan = 'Perlu servis ringan' WHERE ID_Motor = 2;
UPDATE Motor SET Keterangan = 'Motor favorit pelanggan' WHERE ID_Motor = 3;
SELECT * FROM motor; 

-- No 2.
SELECT 
    s.ID_Sewa,
    p.Nama AS Nama_Pelanggan,
    s.TglSewa,
    s.TglRencanaKembali
FROM 
    Sewa s
JOIN 
    Pelanggan p ON s.ID_Pelanggan = p.ID_Pelanggan;
-- No 3.
SELECT * FROM Motor ORDER BY Tahun DESC;
SELECT * FROM Pelanggan ORDER BY Nama ASC;
SELECT * FROM Pembayaran ORDER BY TanggalBayar DESC, JumlahBayar ASC;
-- No 4.
ALTER TABLE Petugas MODIFY COLUMN PASSWORD TEXT;
SELECT * FROM petugas;
-- No 5.
-- Left Join: Menampilkan semua motor, termasuk yang belum disewa
SELECT 
    m.ID_Motor,
    m.Merek,
    s.ID_Sewa
FROM Motor m
LEFT JOIN Sewa s ON m.ID_Motor = s.ID_Motor;
-- Right Join: Menampilkan semua sewa termasuk jika motornya sudah dihapus
SELECT 
    s.ID_Sewa,
    m.Merek
FROM Motor m
RIGHT JOIN Sewa s ON m.ID_Motor = s.ID_Motor;
-- Self Join: Menampilkan petugas dengan nama berbeda tapi username sama panjang (contoh logika)
SELECT 
    p1.Nama AS Petugas1,
    p2.Nama AS Petugas2,
    LENGTH(p1.Username) AS PanjangUsername
FROM Petugas p1
JOIN Petugas p2 
  ON LENGTH(p1.Username) = LENGTH(p2.Username) 
  AND p1.ID_Petugas < p2.ID_Petugas;
-- No 6.
-- 1. Sama dengan
SELECT * FROM Motor WHERE Merek = 'Honda';

-- 2. Tidak sama dengan
SELECT * FROM Pelanggan WHERE Nama <> 'Andi';

-- 3. Lebih besar dari
SELECT * FROM Pembayaran WHERE JumlahBayar > 100000;

-- 4. Kurang dari atau sama dengan
SELECT * FROM Pengembalian WHERE Denda <= 50000;

-- 5. BETWEEN (range tanggal pengembalian)
SELECT * FROM Pengembalian 
WHERE TglDikembalikan BETWEEN '2024-04-01' AND '2024-04-30';

-- 6. IN (beberapa nama petugas)
SELECT * FROM Petugas 
WHERE Nama IN ('Budi', 'Rina');

-- 7. LIKE (pola nama pelanggan dimulai dengan 'A')
SELECT * FROM Pelanggan WHERE Nama LIKE 'A%';







