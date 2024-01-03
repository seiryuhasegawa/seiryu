1. buat database dengan nim 
create database `281`;

2.import database

3. implementasi ilustrasi dengan foreign key yang sesuai
FOREIGN KEY (IdPasien) REFERENCES Pasien(IdPasien) > table rawatinap
FOREIGN KEY (IdPasien) REFERENCES Pasien(IdPasien), > table rekam medis
FOREIGN KEY (IdDokter) REFERENCES Dokter(IdDokter) 

4.tampilkan data pasien
SELECT * FROM Pasien;

5.tampilkan nama dan alamat pasien yang memiliki jenis kelamin perempuan
SELECT Nama, Alamat FROM Pasien WHERE JenisKelamin = 'Perempuan';

6. cari dokter yang memiliki jadwal praktek pada hari senin
SELECT * FROM Dokter WHERE JadwalPraktek LIKE '%Senin%';

7, cari dokter yang memiliki jadwal praktek pada hari kamis
SELECT * FROM Dokter WHERE JadwalPraktek LIKE '%Kamis%';

8. tampilkan nomor kamar dan tanggal keluar rawat inap untuk pasien yang telah keluar dari rawat inap
SELECT NomorKamar, TanggalKeluar FROM RawatInap WHERE TanggalKeluar IS NOT NULL;

9.hitung jumlah pasien berdasarkan jenis kelamin
SELECT JenisKelamin, COUNT(*) as JumlahPasien FROM Pasien GROUP BY JenisKelamin;

10. tampilkan nomor kamar yang sering digunakan
SELECT NomorKamar, COUNT(NomorKamar) as JumlahPenggunaan FROM RawatInap GROUP BY NomorKamar ORDER BY JumlahPenggunaan DESC LIMIT 1;

11. tampilkan rata rata umur pasien
SELECT AVG(Umur) as RataRataUmur FROM Pasien;

12. tampilkan banyaknya pasien
SELECT COUNT(*) as JumlahPasien FROM Pasien;

13. tampilkan umur tertua dari pasien
SELECT MAX(Umur) as UmurTertua FROM Pasien;

14. tampilkan umur pasien paling muda
SELECT MIN(Umur) as UmurTermuda FROM Pasien;

15. tampikan total pemasukan yang diterima rumah sakit
SELECT SUM(Biaya) as TotalPemasukan FROM RawatInap;

16.tampilan data rekam medis dengan informasi pasien dan dokter yang bersangkutan (dengan join)
SELECT RekamMedis.*, Pasien.Nama as NamaPasien, Dokter.Nama as NamaDokter
FROM RekamMedis
JOIN Pasien ON RekamMedis.IdPasien = Pasien.IdPasien
JOIN Dokter ON RekamMedis.IdDokter = Dokter.IdDokter;

17.tampilkan rekam medis pasien yang memiliki umur di at5as ata rata umur pasien lainya (subquery)
SELECT *
FROM RekamMedis
WHERE IdPasien IN (SELECT IdPasien FROM Pasien WHERE Umur > (SELECT AVG(Umur) FROM Pasien));

18.tampilkan jumlah rekam medis untuk setiap pasien (subquery)
SELECT IdPasien, COUNT(*) as JumlahRekamMedis
FROM RekamMedis
GROUP BY IdPasien;

19.tambahkan kolom status pada table pasien(triggers)
ALTER TABLE Pasien
ADD COLUMN Status VARCHAR(50);

20. buatlah triggers dengan ketentuan jika pasien masuk rawat inap maka status "dalam rawat inap" jika keluar atau dihapus maka "keluar dari rawat inap"
CREATE TRIGGER SetStatusPasien
AFTER INSERT ON RawatInap
FOR EACH ROW
UPDATE Pasien
SET Status = 'Dalam Rawat Inap'
WHERE IdPasien = NEW.IdPasien;

CREATE TRIGGER SetStatusPasienKeluar
AFTER UPDATE ON RawatInap
FOR EACH ROW
UPDATE Pasien
SET Status = 'Keluar dari Rawat Inap'
WHERE IdPasien = OLD.IdPasien;

