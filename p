import java.util.ArrayList;
import java.util.Scanner;

class Buku {
    private String judul;
    private String pengarang;

    public Buku(String judul, String pengarang) {
        this.judul = judul;
        this.pengarang = pengarang;
    }

    public String getJudul() {
        return judul;
    }

    public String getPengarang() {
        return pengarang;
    }

    @Override
    public String toString() {
        return "Buku{" +
                "judul='" + judul + '\'' +
                ", pengarang='" + pengarang + '\'' +
                '}';
    }
}

class AnggotaPerpustakaan {
    private String nama;
    private ArrayList<Buku> bukuDipinjam = new ArrayList<>();

    public AnggotaPerpustakaan(String nama) {
        this.nama = nama;
    }

    public String getNama() {
        return nama;
    }

    public ArrayList<Buku> getBukuDipinjam() {
        return bukuDipinjam;
    }

    public void pinjamBuku(Buku buku) {
        bukuDipinjam.add(buku);
    }

    public void kembalikanBuku(Buku buku) {
        bukuDipinjam.remove(buku);
    }

    @Override
    public String toString() {
        return "AnggotaPerpustakaan{" +
                "nama='" + nama + '\'' +
                ", bukuDipinjam=" + bukuDipinjam +
                '}';
    }
}

class Perpustakaan {
    private ArrayList<Buku> arsipBuku = new ArrayList<>();
    private ArrayList<AnggotaPerpustakaan> anggotaList = new ArrayList<>();

    public void tambahBuku(Buku buku) {
        arsipBuku.add(buku);
        System.out.println("Buku berhasil ditambahkan ke arsip.");
    }

    public void tambahAnggota(AnggotaPerpustakaan anggota) {
        anggotaList.add(anggota);
        System.out.println("Anggota berhasil ditambahkan.");
    }

    public void tampilkanArsipBuku() {
        System.out.println("Arsip Buku:");
        for (Buku buku : arsipBuku) {
            System.out.println(buku);
        }
    }

    public Buku cariBuku(String judul) {
        for (Buku buku : arsipBuku) {
            if (buku.getJudul().equalsIgnoreCase(judul)) {
                return buku;
            }
        }
        return null;
    }

    public AnggotaPerpustakaan cariAnggota(String nama) {
        for (AnggotaPerpustakaan anggota : anggotaList) {
            if (anggota.getNama().equalsIgnoreCase(nama)) {
                return anggota;
            }
        }
        return null;
    }

    public void anggotaPinjamBuku(AnggotaPerpustakaan anggota, Buku buku) {
        if (!anggota.getBukuDipinjam().contains(buku)) {
            anggota.pinjamBuku(buku);
            System.out.println("Buku berhasil dipinjam oleh " + anggota.getNama());
        } else {
            System.out.println("Anggota sudah meminjam buku ini sebelumnya.");
        }
    }

    public void anggotaKembalikanBuku(AnggotaPerpustakaan anggota, Buku buku) {
        if (anggota.getBukuDipinjam().contains(buku)) {
            anggota.kembalikanBuku(buku);
            System.out.println("Buku berhasil dikembalikan oleh " + anggota.getNama());
        } else {
            System.out.println("Anggota tidak meminjam buku ini.");
        }
    }

    public void tampilkanStatistik() {
        System.out.println("Statistik Perpustakaan:");
        System.out.println("Jumlah Buku: " + arsipBuku.size());
        System.out.println("Jumlah Anggota: " + anggotaList.size());
    }
}

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Perpustakaan perpustakaan = new Perpustakaan();

        while (true) {
            System.out.println("Menu Perpustakaan:");
            System.out.println("1. Tambah Buku");
            System.out.println("2. Tambah Anggota");
            System.out.println("3. Tampilkan Arsip Buku");
            System.out.println("4. Pinjam Buku");
            System.out.println("5. Kembalikan Buku");
            System.out.println("6. Tampilkan Statistik");
            System.out.println("7. Keluar");

            System.out.print("Masukkan pilihan Anda: ");
            int pilihan = scanner.nextInt();

            switch (pilihan) {
                case 1:
                    // Tambah Buku
                    System.out.print("Judul Buku: ");
                    String judulBuku = scanner.next();
                    System.out.print("Pengarang: ");
                    String pengarangBuku = scanner.next();
                    perpustakaan.tambahBuku(new Buku(judulBuku, pengarangBuku));
                    break;
                case 2:
                    // Tambah Anggota
                    System.out.print("Nama Anggota: ");
                    String namaAnggota = scanner.next();
                    perpustakaan.tambahAnggota(new AnggotaPerpustakaan(namaAnggota));
                    break;
                case 3:
                    // Tampilkan Arsip Buku
                    perpustakaan.tampilkanArsipBuku();
                    break;
                case 4:
                    // Pinjam Buku
                    System.out.print("Nama Anggota: ");
                    String namaAnggotaPinjam = scanner.next();
                    System.out.print("Judul Buku: ");
                    String judulBukuPinjam = scanner.next();
                    Buku bukuPinjam = perpustakaan.cariBuku(judulBukuPinjam);
                    AnggotaPerpustakaan anggotaPinjam = perpustakaan.cariAnggota(namaAnggotaPinjam);
                    if (bukuPinjam != null && anggotaPinjam != null) {
                        perpustakaan.anggotaPinjamBuku(anggotaPinjam, bukuPinjam);
                    } else {
                        System.out.println("Buku atau anggota tidak ditemukan.");
                    }
                    break;
                case 5:
                    // Kembalikan Buku
                    System.out.print("Nama Anggota: ");
                    String namaAnggotaKembali = scanner.next();
                    System.out.print("Judul Buku: ");
                    String judulBukuKembali = scanner.next();
                    Buku bukuKembali = perpustakaan.cariBuku(judulBukuKembali);
                    AnggotaPerpustakaan anggotaKembali = perpustakaan.cariAnggota(namaAnggotaKembali);
                    if (bukuKembali != null && anggotaKembali != null) {
                        perpustakaan.anggotaKembalikanBuku(anggotaKembali, bukuKembali);
                    } else {
                        System.out.println("Buku atau anggota tidak ditemukan.");
                    }
                    break;
                case 6:
                    // Tampilkan Statistik
                    perpustakaan.tampilkanStatistik();
                    break;
                case 7:
                    System.out.println("Program selesai.");
                    System.exit(0);
                    break;
                default:
                    System.out.println("Pilihan tidak valid.");
            }
        }
    }
}
