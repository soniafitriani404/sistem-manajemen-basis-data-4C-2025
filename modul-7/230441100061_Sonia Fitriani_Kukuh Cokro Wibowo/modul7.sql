USE `rental_sepeda_motor`;
-- no 1
-- insert
DELIMITER //

CREATE TRIGGER before_insert_sewa
BEFORE INSERT ON Sewa
FOR EACH ROW
BEGIN
  DECLARE motor_status ENUM('Tersedia','Disewa');

  SELECT STATUS INTO motor_status FROM Motor WHERE ID_Motor = NEW.ID_Motor;

  IF motor_status != 'Tersedia' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Motor tidak tersedia untuk disewa!';
  END IF;
END; //

DELIMITER ;
INSERT INTO Sewa (ID_Pelanggan, ID_Motor, ID_Petugas, TglSewa, TglRencanaKembali) 
VALUES (1, 1, 1, '2024-05-20', '2024-05-22');
SELECT ID_Motor, STATUS FROM Motor WHERE ID_Motor = 1;

-- update
DELIMITER //

CREATE TRIGGER before_update_motor
BEFORE UPDATE ON Motor
FOR EACH ROW
BEGIN
  IF NEW.STATUS NOT IN ('Tersedia', 'Disewa') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Status motor hanya boleh Tersedia atau Disewa!';
  END IF;
END; //

DELIMITER ;
UPDATE Motor SET STATUS = 'Tersedia' WHERE ID_Motor = 1;
SELECT * FROM Motor;
-- delete
DELIMITER //

CREATE TRIGGER before_delete_pelanggan
BEFORE DELETE ON Pelanggan
FOR EACH ROW
BEGIN
  IF EXISTS (SELECT 1 FROM Sewa WHERE ID_Pelanggan = OLD.ID_Pelanggan) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pelanggan masih punya transaksi sewa aktif, tidak bisa dihapus!';
  END IF;
END; //

DELIMITER ;
DELETE FROM Pelanggan WHERE ID_Pelanggan = 6;
SELECT * FROM Pelanggan;
-- no 2
-- insert
DELIMITER //

CREATE TRIGGER after_insert_sewa
AFTER INSERT ON Sewa
FOR EACH ROW
BEGIN
  UPDATE Motor SET STATUS = 'Disewa' WHERE ID_Motor = NEW.ID_Motor;
END; //

DELIMITER ;
INSERT INTO Sewa (ID_Pelanggan, ID_Motor, ID_Petugas, TglSewa, TglRencanaKembali)
VALUES (1, 1, 1, '2025-05-19', '2025-05-22');
SELECT ID_Motor, STATUS FROM Motor WHERE ID_Motor = 1;
-- update
DELIMITER //

CREATE TRIGGER after_update_pengembalian
AFTER UPDATE ON Pengembalian
FOR EACH ROW
BEGIN
  DECLARE id_motor INT;

  SELECT ID_Motor INTO id_motor
  FROM Sewa
  WHERE ID_Sewa = NEW.ID_Sewa;

  UPDATE Motor
  SET STATUS = 'Disewa'
  WHERE ID_Motor = id_motor;
END; //

DELIMITER ;
UPDATE Pengembalian
SET TglDikembalikan = '2025-05-19'
WHERE ID_Pengembalian = 2;
SELECT m.ID_Motor, m.STATUS
FROM Motor m
JOIN Sewa s ON m.ID_Motor = s.ID_Motor
JOIN Pengembalian p ON s.ID_Sewa = p.ID_Sewa
WHERE p.ID_Pengembalian = 2;
SELECT * FROM Pengembalian;

-- delete 
DELIMITER //

CREATE TRIGGER after_delete_sewa
AFTER DELETE ON Sewa
FOR EACH ROW
BEGIN
  UPDATE Motor 
  SET STATUS = 'Tersedia' 
  WHERE ID_Motor = OLD.ID_Motor;
END; //

DELIMITER ;
SELECT * FROM Motor WHERE ID_Motor = 3;
DELETE FROM Pengembalian WHERE ID_Sewa = 3;
DELETE FROM Pembayaran WHERE ID_Sewa = 3;
DELETE FROM Sewa WHERE ID_Sewa = 3;
SELECT * FROM Motor WHERE ID_Motor = 3;











