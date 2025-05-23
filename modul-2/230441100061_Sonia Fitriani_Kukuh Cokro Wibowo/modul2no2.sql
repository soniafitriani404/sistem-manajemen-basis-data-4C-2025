-- no1
CREATE VIEW view_sewa_pelanggan AS
SELECT 
    s.ID_Sewa,
    p.Nama AS Nama_Pelanggan,
    s.TglSewa,
    s.TglRencanaKembali
FROM Sewa s
JOIN Pelanggan p ON s.ID_Pelanggan = p.ID_Pelanggan;
-- no 2
CREATE VIEW view_sewa_lengkap AS
SELECT 
    s.ID_Sewa,
    p.Nama AS Nama_Pelanggan,
    m.PlatNomor,
    m.Merek,
    s.TglSewa,
    s.TglRencanaKembali
FROM Sewa s
JOIN Pelanggan p ON s.ID_Pelanggan = p.ID_Pelanggan
JOIN Motor m ON s.ID_Motor = m.ID_Motor;
-- no 3
CREATE VIEW view_pengembalian_terlambat AS
SELECT 
    se.ID_Sewa,
    pl.Nama AS Nama_Pelanggan,
    se.TglRencanaKembali,
    pk.TglDikembalikan,
    pk.Denda
FROM Pengembalian pk
JOIN Sewa se ON pk.ID_Sewa = se.ID_Sewa
JOIN Pelanggan pl ON se.ID_Pelanggan = pl.ID_Pelanggan
WHERE pk.TglDikembalikan > se.TglRencanaKembali;
-- no 4
CREATE VIEW view_total_pembayaran_per_metode_lengkap AS
SELECT 
    p.Metode,
    COUNT(p.ID_Pembayaran) AS Jumlah_Transaksi,
    SUM(p.JumlahBayar) AS Total_Bayar,
    AVG(p.JumlahBayar) AS RataRata_Bayar,
    MIN(p.JumlahBayar) AS Pembayaran_Terkecil,
    MAX(p.JumlahBayar) AS Pembayaran_Terbesar
FROM Pembayaran p
JOIN Sewa s ON p.ID_Sewa = s.ID_Sewa
GROUP BY p.Metode;

-- no 5
CREATE VIEW View_Laporan_Transaksi AS
SELECT 
    s.ID_Sewa,
    p.Nama AS Nama_Pelanggan,
    m.PlatNomor,
    m.Merek,
    m.Tipe,
    s.TglSewa,
    s.TglRencanaKembali,
    k.TglDikembalikan,
    k.Denda,
    k.KondisiMotor,
    b.TanggalBayar,
    b.JumlahBayar,
    b.Metode,
    pet.Nama AS Nama_Petugas
FROM 
    Sewa s
JOIN 
    Pelanggan p ON s.ID_Pelanggan = p.ID_Pelanggan
JOIN 
    Motor m ON s.ID_Motor = m.ID_Motor
JOIN 
    Petugas pet ON s.ID_Petugas = pet.ID_Petugas
LEFT JOIN 
    Pengembalian k ON s.ID_Sewa = k.ID_Sewa
LEFT JOIN 
    Pembayaran b ON s.ID_Sewa = b.ID_Sewa;
