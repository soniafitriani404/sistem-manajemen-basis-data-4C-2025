USE`transaksi`;
-- Tabel user
CREATE TABLE USER (
 id_user INT PRIMARY KEY,
 nama VARCHAR(100)
);

-- Tabel transaksi
CREATE TABLE transaksi (
 id_transaksi INT PRIMARY KEY,
 id_user INT,
 tanggal_transaksi DATE,
 STATUS VARCHAR(50),
 jumlah INT,
 FOREIGN KEY (id_user) REFERENCES USER(id_user)
);
-- Tambah user
INSERT INTO USER (id_user, nama) VALUES
(1, 'Aldi'),
(2, 'Budi'),
(3, 'Citra');

-- Tambah transaksi
INSERT INTO transaksi (id_transaksi, id_user, tanggal_transaksi, STATUS, jumlah) VALUES
(1, 1, CURDATE() - INTERVAL 5 DAY, 'lunas', 100000),
(2, 2, CURDATE() - INTERVAL 10 DAY, 'selesai', 250000),
(3, 2, CURDATE() - INTERVAL 20 DAY, 'proses', 150000),
(4, 1, CURDATE() - INTERVAL 2 MONTH, 'sukses', 300000),
(5, 3, CURDATE() - INTERVAL 14 MONTH, 'lunas', 50000),
(6, 1, CURDATE() - INTERVAL 15 DAY, 'sukses', 200000),
(7, 1, CURDATE() - INTERVAL 25 DAY, 'gagal', 75000),
(8, 2, CURDATE() - INTERVAL 1 MONTH, 'sukses', 180000);

-- no 1
DELIMITER //

CREATE PROCEDURE tampilkan_transaksi_berdasarkan_lama(IN pilihan VARCHAR(10))
BEGIN
 SELECT * FROM transaksi
 WHERE tanggal_transaksi >= 
 CASE 
 WHEN pilihan = 'SEMINGGU' THEN CURDATE() - INTERVAL 7 DAY
 WHEN pilihan = '1 BULAN' THEN CURDATE() - INTERVAL 1 MONTH
 WHEN pilihan = '3 BULAN' THEN CURDATE() - INTERVAL 3 MONTH
 ELSE '1000-01-01'
 END;
END //

DELIMITER ;

CALL tampilkan_transaksi_berdasarkan_lama('SEMINGGU');
-- Atau
CALL tampilkan_transaksi_berdasarkan_lama('1 BULAN');
-- Atau
CALL tampilkan_transaksi_berdasarkan_lama('3 BULAN');

-- no 2
DELIMITER //

CREATE PROCEDURE hapus_transaksi_lama()
BEGIN
 DELETE FROM transaksi
 WHERE tanggal_transaksi < CURDATE() - INTERVAL 1 YEAR
 AND STATUS IN ('selesai', 'lunas', 'kembali');
END //

DELIMITER ;
CALL tampilkan_transaksi_berdasarkan_lama('1 BULAN');
CALL hitung_transaksi_berhasil();

-- no 3
DELIMITER //

CREATE PROCEDURE ubah_status_transaksi()
BEGIN
 UPDATE transaksi
 JOIN (
 SELECT id_transaksi
 FROM transaksi
 ORDER BY tanggal_transaksi ASC
 LIMIT 7
 ) AS temp USING (id_transaksi)
 SET transaksi.status = 'sukses';
END //

DELIMITER ;
CALL ubah_status_transaksi();
SELECT * FROM transaksi;
-- no 4
DELIMITER //

CREATE PROCEDURE edit_user_bebas(
 IN p_id_user INT,
 IN p_nama_baru VARCHAR(100)
)
BEGIN
 UPDATE USER
 SET nama = p_nama_baru
 WHERE id_user = p_id_user;
END //

DELIMITER ;

CALL edit_user_bebas(1, 'Sonia');

SELECT * FROM USER;SELECT * FROM USER
WHERE id_user NOT IN (
 SELECT DISTINCT id_user FROM transaksi
);

-- no 5
DELIMITER //

CREATE PROCEDURE update_status_transaksi_terbaru()
BEGIN
 DECLARE id_terkecil INT;
 DECLARE id_median INT;
 DECLARE id_terbesar INT;
 DECLARE total_transaksi INT;
 DECLARE offset_median INT;

 -- Buat tabel sementara berisi transaksi 1 bulan terakhir
 DROP TEMPORARY TABLE IF EXISTS temp_transaksi;

 CREATE TEMPORARY TABLE temp_transaksi AS
 SELECT id_transaksi, jumlah
 FROM transaksi
 WHERE tanggal_transaksi >= CURDATE() - INTERVAL 1 MONTH
 ORDER BY jumlah;

 -- Hitung jumlah total transaksi
 SELECT COUNT(*) INTO total_transaksi FROM temp_transaksi;

 -- Hitung posisi median
 SET offset_median = FLOOR(total_transaksi / 2);

 -- Ambil id terkecil
 SELECT id_transaksi INTO id_terkecil
 FROM temp_transaksi
 ORDER BY jumlah ASC
 LIMIT 1;

 -- Ambil id terbesar
 SELECT id_transaksi INTO id_terbesar
 FROM temp_transaksi
 ORDER BY jumlah DESC
 LIMIT 1;

 -- Ambil id median
 SELECT id_transaksi INTO id_median
 FROM temp_transaksi
 LIMIT 1 OFFSET offset_median;

 -- Update status sesuai ketentuan
 UPDATE transaksi SET STATUS = 'non-aktif' WHERE id_transaksi = id_terkecil;
 UPDATE transaksi SET STATUS = 'aktif' WHERE id_transaksi = id_terbesar;
 UPDATE transaksi SET STATUS = 'pasif' WHERE id_transaksi = id_median;

 -- Hapus tabel sementara
 DROP TEMPORARY TABLE IF EXISTS temp_transaksi;
END //

DELIMITER ;
CALL update_status_transaksi_terbaru();
SELECT * FROM transaksi
WHERE tanggal_transaksi >= CURDATE() - INTERVAL 1 MONTH
ORDER BY jumlah;

-- no 6
DELIMITER //

CREATE PROCEDURE hitung_transaksi_berhasil()
BEGIN
 DECLARE selesai INT DEFAULT 0;
 DECLARE jumlah INT DEFAULT 0;
 WHILE selesai = 0 DO
 SELECT COUNT(*) INTO jumlah
 FROM transaksi
 WHERE STATUS = 'sukses'
 AND tanggal_transaksi >= CURDATE() - INTERVAL 1 MONTH;

 SELECT CONCAT('Jumlah transaksi sukses 1 bulan terakhir: ', jumlah) AS info;

 SET selesai = 1;
 END WHILE;
END //

DELIMITER ;
CALL hitung_transaksi_berhasil();
