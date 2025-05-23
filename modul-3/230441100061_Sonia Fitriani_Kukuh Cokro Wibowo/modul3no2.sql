USE`rental_sepeda_motor`;
-- no1
DELIMITER //

CREATE PROCEDURE UpdateDataMaster (
    IN p_id INT,
    IN p_nilai_baru VARCHAR(255),
    OUT p_status_operasi VARCHAR(50)
)
BEGIN
    -- Melakukan update pada kolom Nama di tabel Pelanggan berdasarkan ID_Pelanggan
    UPDATE Pelanggan
    SET Nama = p_nilai_baru
    WHERE ID_Pelanggan = p_id;

    -- Memeriksa apakah update berhasil
    IF ROW_COUNT() > 0 THEN
        SET p_status_operasi = 'Update berhasil'; -- Jika ada baris yang terpengaruh
    ELSE
        SET p_status_operasi = 'Update gagal: ID tidak ditemukan'; -- Jika tidak ada baris yang terpengaruh
    END IF;
END //

DELIMITER ;



SET @status_operasi = '';
CALL UpdateDataMaster(1, 'Andi Santosa', @status_operasi);
SELECT @status_operasi;

-- no2
DELIMITER //

CREATE PROCEDURE CountTransaksi (
    OUT p_jumlah_transaksi INT
)
BEGIN
    -- Menghitung jumlah transaksi
    SELECT COUNT(*) INTO p_jumlah_transaksi
    FROM Sewa;
END //

DELIMITER ;

CALL CountTransaksi(@jumlah_transaksi);
SELECT @jumlah_transaksi;

-- no3
DELIMITER //

CREATE PROCEDURE GetDataMasterByID (
    IN p_id INT,
    OUT p_nama VARCHAR(100),
    OUT p_alamat TEXT,
    OUT p_no_hp VARCHAR(15)
)
BEGIN
    -- Mengambil data berdasarkan ID
    SELECT Nama, Alamat, NoHP
    INTO p_nama, p_alamat, p_no_hp
    FROM Pelanggan
    WHERE ID_Pelanggan = p_id;
END //

DELIMITER ;

CALL GetDataMasterByID(1, @p_nama, @p_alamat, @p_no_hp);
SELECT @p_nama, @p_alamat, @p_no_hp;


-- no4

DELIMITER //

CREATE PROCEDURE UpdateFieldTransaksi (
    IN p_id INT,
    INOUT p_field1 DATE,
    INOUT p_field2 DATE
)
BEGIN
    -- Update transaksi berdasarkan ID dan mengubah field1 dan field2 di tabel Sewa
    UPDATE Sewa
    SET TglSewa = COALESCE(p_field1, TglSewa),
        TglRencanaKembali = COALESCE(p_field2, TglRencanaKembali)
    WHERE ID_Sewa = p_id;
END //

DELIMITER ;

-- Deklarasi variabel untuk parameter INOUT
SET @new_field1 = '2024-04-15';
SET @new_field2 = '2024-04-18';
SET @status_operasi = '';

-- Memanggil prosedur
CALL UpdateFieldTransaksi(1, @new_field1, @new_field2);

-- Memeriksa hasil
SELECT @new_field1, @new_field2;

-- no5
DELIMITER //

CREATE PROCEDURE DeleteEntriesByIDMaster (
    IN p_id INT
)
BEGIN
    -- Menghapus data terkait dari Pengembalian dan Pembayaran
    DELETE FROM Pengembalian WHERE ID_Sewa = p_id;
    DELETE FROM Pembayaran WHERE ID_Sewa = p_id;

    -- Menghapus data dari tabel Sewa
    DELETE FROM Sewa WHERE ID_Sewa = p_id;
END //

DELIMITER ;


CALL DeleteEntriesByIDMaster(1);
SELECT * FROM Sewa;

