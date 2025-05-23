/*
SQLyog Community v13.3.0 (64 bit)
MySQL - 10.4.28-MariaDB : Database - akademik_program_studi
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`akademik_program_studi` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `akademik_program_studi`;

/*Table structure for table `dosen` */

DROP TABLE IF EXISTS `dosen`;

CREATE TABLE `dosen` (
  `id_dosen` int(11) NOT NULL AUTO_INCREMENT,
  `NIDN` varchar(10) DEFAULT NULL,
  `Nama` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `NoHP` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id_dosen`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `dosen` */

insert  into `dosen`(`id_dosen`,`NIDN`,`Nama`,`Email`,`NoHP`) values 
(1,'ND001','Dr. Siti','siti@kampus.ac.id','081234567001'),
(2,'ND002','Dr. Budi','budi@kampus.ac.id','081234567002'),
(3,'ND003','Dr. Tono','tono@kampus.ac.id','081234567003'),
(4,'ND004','Dr. Ani','ani@kampus.ac.id','081234567004'),
(5,'ND005','Dr. Lina','lina@kampus.ac.id','081234567005'),
(6,'ND006','Dr. Rudi','rudi@kampus.ac.id','081234567006'),
(7,'ND007','Dr. Wati','wati@kampus.ac.id','081234567007'),
(8,'ND008','Dr. Eko','eko@kampus.ac.id','081234567008'),
(9,'ND008','Dr. Yani','yani@kampus.ac.id','081234567009'),
(10,'ND009','Dr. Dani','dani@kampus.ac.id','081234567010');

/*Table structure for table `krs` */

DROP TABLE IF EXISTS `krs`;

CREATE TABLE `krs` (
  `IDKRS` int(11) NOT NULL AUTO_INCREMENT,
  `NIM` char(10) DEFAULT NULL,
  `KodeMK` char(6) DEFAULT NULL,
  `TahunAjaran` varchar(9) DEFAULT NULL,
  `Semester` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`IDKRS`),
  KEY `NIM` (`NIM`),
  KEY `KodeMK` (`KodeMK`),
  CONSTRAINT `krs_ibfk_1` FOREIGN KEY (`NIM`) REFERENCES `mahasiswa` (`NIM`),
  CONSTRAINT `krs_ibfk_2` FOREIGN KEY (`KodeMK`) REFERENCES `matakuliah` (`KodeMK`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `krs` */

insert  into `krs`(`IDKRS`,`NIM`,`KodeMK`,`TahunAjaran`,`Semester`) values 
(1,'M001','MK001','2024/2025','Ganjil'),
(2,'M002','MK002','2024/2025','Ganjil'),
(3,'M003','MK003','2024/2025','Genap'),
(4,'M004','MK004','2024/2025','Genap'),
(5,'M005','MK005','2024/2025','Ganjil'),
(6,'M001','MK001','2024/2025','Ganjil'),
(7,'M002','MK002','2024/2025','Ganjil'),
(8,'M003','MK003','2024/2025','Genap'),
(9,'M004','MK004','2024/2025','Genap'),
(10,'M005','MK005','2024/2025','Ganjil');

/*Table structure for table `mahasiswa` */

DROP TABLE IF EXISTS `mahasiswa`;

CREATE TABLE `mahasiswa` (
  `NIM` char(10) NOT NULL,
  `Nama` varchar(100) DEFAULT NULL,
  `JenisKelamin` enum('L','P') DEFAULT NULL,
  `Alamat` text DEFAULT NULL,
  `TglLahir` date DEFAULT NULL,
  PRIMARY KEY (`NIM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `mahasiswa` */

insert  into `mahasiswa`(`NIM`,`Nama`,`JenisKelamin`,`Alamat`,`TglLahir`) values 
('M001','Andi','L','Jl. Melati 1','2002-01-10'),
('M002','Budi','L','Jl. Mawar 2','2002-02-20'),
('M003','Citra','P','Jl. Kenanga 3','2001-03-15'),
('M004','Dina','P','Jl. Anggrek 4','2001-04-25'),
('M005','Eka','L','Jl. Teratai 5','2000-05-05'),
('M006','Farah','P','Jl. Kamboja 6','2000-06-06'),
('M007','Gilang','L','Jl. Dahlia 7','1999-07-07'),
('M008','Hana','P','Jl. Flamboyan 8','1999-08-08'),
('M009','Ivan','L','Jl. Cemara 9','1998-09-09'),
('M010','Joko','L','Jl. Merpati 10','1998-10-10');

/*Table structure for table `matakuliah` */

DROP TABLE IF EXISTS `matakuliah`;

CREATE TABLE `matakuliah` (
  `KodeMK` char(6) NOT NULL,
  `NamaMK` varchar(100) DEFAULT NULL,
  `SKS` int(11) DEFAULT NULL,
  `Semester` int(11) DEFAULT NULL,
  `id_dosen` int(11) DEFAULT NULL,
  PRIMARY KEY (`KodeMK`),
  KEY `id_dosen` (`id_dosen`),
  CONSTRAINT `matakuliah_ibfk_1` FOREIGN KEY (`id_dosen`) REFERENCES `dosen` (`id_dosen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `matakuliah` */

insert  into `matakuliah`(`KodeMK`,`NamaMK`,`SKS`,`Semester`,`id_dosen`) values 
('MK001','Pemrograman Dasar',3,2,1),
('MK002','Struktur Data',3,2,2),
('MK003','Basis Data',3,2,3),
('MK004','Sistem Operasi',3,2,4),
('MK005','Jaringan Komputer',3,2,5),
('MK006','Kecerdasan Buatan',3,2,6),
('MK007','Pemrograman Web',3,2,7),
('MK008','Algoritma & Logika',3,2,8),
('MK009','Sistem Informasi',3,2,9),
('MK010','Manajemen Proyek',3,2,10);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
