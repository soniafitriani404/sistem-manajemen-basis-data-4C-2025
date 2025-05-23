USE `umkm_jawa_barat`;

-- n0 1
DELIMITER //

CREATE PROCEDURE AddUMKM (
    IN p_nama_usaha VARCHAR(255),
    IN p_jumlah_karyawan INT
)
BEGIN
    INSERT INTO umkm (nama_usaha, jumlah_karyawan)
    VALUES (p_nama_usaha, p_jumlah_karyawan);
END //

DELIMITER ;

CALL AddUMKM(16,'Toko Serba Ada',16,16,16,17,'Jl. Mawar No. 79, Malang','001234581','09.876.543.2-123.014',2010,25,3500000000.00,20000000000.00,'Perkebunan dan pengolahan kopi premium','2020-01-05'););
SELECT * FROM UMKM;


-- n0 2
DELIMITER //

CREATE PROCEDURE UpdateKategoriUMKM (
    IN p_id_kategori INT,
    IN p_nama_baru VARCHAR(255)
)
BEGIN
    UPDATE kategori_umkm
    SET nama_kategori = p_nama_baru
    WHERE id_kategori = p_id_kategori;
END //

DELIMITER ;
-- no 3
DELIMITER //

CREATE PROCEDURE DeletePemilikUMKM (
    IN p_id_pemilik INT
)
BEGIN
    DELETE FROM pemilik_umkm
    WHERE id_pemilik = p_id_pemilik;
END //

DELIMITER ;
-- no 5
DELIMITER //

CREATE PROCEDURE AddProduk (
    IN p_id_umkm INT,
    IN p_nama_produk VARCHAR(255),
    IN p_harga DECIMAL(15,2)
)
BEGIN
    INSERT INTO produk_umkm (id_umkm, nama_produk, harga)
    VALUES (p_id_umkm, p_nama_produk, p_harga);
END //

DELIMITER ;

-- no 5
DELIMITER //

CREATE PROCEDURE GetUMKMByID (
    IN p_id_umkm INT,
    OUT p_nama_usaha VARCHAR(255),
    OUT p_jumlah_karyawan INT
)
BEGIN
    SELECT nama_usaha, jumlah_karyawan
    INTO p_nama_usaha, p_jumlah_karyawan
    FROM umkm
    WHERE id_umkm = p_id_umkm;
END //

DELIMITER ;


