4.tampilkan data pasien 
SELECT * FROM pasien;
5.Tampilkan nama dan alamat pasien yang memiliki jenis kelamin perempuan 
SELECT nama, alamat FROM pasien WHERE jenis_kelamin = 'perempuan';
6.Cari dokter yang memiliki jadwal praktek pada hari Senin
SELECT * FROM dokter WHERE jadwal_praktek LIKE '%Senin%';
7.Cari dokter yang memiliki jadwal praktek pada hari Kamis
SELECT * FROM dokter WHERE jadwal_praktek LIKE '%Kamis%';
8.Tampilkan nomor kamar dan tanggal keluar rawat inap untuk pasien yang telah keluar dari rawat inap
SELECT nomor_kamar, tanggal_keluar FROM rawat_inap WHERE tanggal_keluar IS NOT NULL;
9.Hitung jumlah pasien berdasarkan jenis kelamin
SELECT jenis_kelamin, COUNT(*) AS jumlah_pasien FROM pasien GROUP BY jenis_kelamin;
10.Tampilkan nomor kamar yang sering digunakan
SELECT nomor_kamar, COUNT(nomor_kamar) AS jumlah_penggunaan FROM rawat_inap GROUP BY nomor_kamar ORDER BY jumlah_penggunaan DESC LIMIT 1;
11.Tampilkan rata-rata umur pasien
SELECT AVG(umur) AS rata_rata_umur FROM pasien;
12.Tampilkan banyaknya pasien
SELECT COUNT(*) AS jumlah_pasien FROM pasien;
13.Tampilkan umur tertua dari pasien
SELECT MAX(umur) AS umur_tertua FROM pasien;
14.Tampilkan umur pasien paling muda
SELECT MIN(umur) AS umur_paling_muda FROM pasien;
15.Tampilkan total pemasukan yang diterima rumah sakit
SELECT SUM(total_biaya) AS total_pemasukan FROM rawat_inap;
16.Tampilkan data rekam medis dengan informasi pasien dan dokter yang bersangkutan (dengan join)
SELECT rekam_medis.*, pasien.nama AS nama_pasien, dokter.nama AS nama_dokter
FROM rekam_medis
JOIN pasien ON rekam_medis.id_pasien = pasien.id_pasien
JOIN dokter ON rekam_medis.id_dokter = dokter.id_dokter;
17.Tampilkan rekam medis pasien yang memiliki umur di atas atau sama dengan rata-rata umur pasien lainnya (subquery)
SELECT * FROM rekam_medis WHERE id_pasien IN (SELECT id_pasien FROM pasien WHERE umur >= (SELECT AVG(umur) FROM pasien));
18.Tampilkan jumlah rekam medis untuk setiap pasien (subquery)
SELECT id_pasien, COUNT(*) AS jumlah_rekam_medis FROM rekam_medis GROUP BY id_pasien;
19.Tambahkan kolom status pada tabel pasien (triggers)
-- Trigger untuk memperbarui status pasien saat ada perubahan pada tabel rawat_inap
CREATE TRIGGER update_status_pasien AFTER INSERT OR UPDATE OR DELETE ON rawat_inap
FOR EACH ROW
BEGIN
    UPDATE pasien
    SET status = CASE
        WHEN NEW.tanggal_keluar IS NOT NULL THEN 'keluar dari rawat inap'
        ELSE 'dalam rawat inap'
    END
    WHERE id_pasien = NEW.id_pasien;
END;
