import java.util.Scanner;

// Interface untuk Senjata
interface Senjata {
    void tembak();
    void reload();
    void cekPeluru();
    void gantiSenjata();
}

// Implementasi Senjata Pistol
class Pistol implements Senjata {
    private int peluru = 6;

    @Override
    public void tembak() {
        if (peluru > 0) {
            System.out.println("Menembak! Sisa peluru: " + --peluru);
        } else {
            System.out.println("Peluru habis. Silakan reload.");
        }
    }

    @Override
    public void reload() {
        peluru = 6;
        System.out.println("Reload selesai. Peluru sekarang: " + peluru);
    }

    @Override
    public void cekPeluru() {
        System.out.println("Sisa peluru: " + peluru);
    }

    @Override
    public void gantiSenjata() {
        System.out.println("Ganti senjata ke Shotgun");
    }
}

// Implementasi Senjata Shotgun
class Shotgun implements Senjata {
    private int peluru = 2;

    @Override
    public void tembak() {
        if (peluru > 0) {
            System.out.println("Menembak! Sisa peluru: " + --peluru);
        } else {
            System.out.println("Peluru habis. Silakan reload.");
        }
    }

    @Override
    public void reload() {
        peluru = 2;
        System.out.println("Reload selesai. Peluru sekarang: " + peluru);
    }

    @Override
    public void cekPeluru() {
        System.out.println("Sisa peluru: " + peluru);
    }

    @Override
    public void gantiSenjata() {
        System.out.println("Ganti senjata ke Pistol");
    }
}

// Kelas utama program
public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Senjata senjata = new Pistol(); // Awalnya menggunakan senjata Pistol

        while (true) {
            System.out.println("Pilihan: ");
            System.out.println("1. Tembak");
            System.out.println("2. Reload");
            System.out.println("3. Cek Peluru");
            System.out.println("4. Ganti Senjata");
            System.out.println("5. Keluar");

            System.out.print("Masukkan pilihan Anda: ");
            int pilihan = scanner.nextInt();

            switch (pilihan) {
                case 1:
                    senjata.tembak();
                    break;
                case 2:
                    senjata.reload();
                    break;
                case 3:
                    senjata.cekPeluru();
                    break;
                case 4:
                    if (senjata instanceof Pistol) {
                        senjata = new Shotgun();
                    } else {
                        senjata = new Pistol();
                    }
                    senjata.gantiSenjata();
                    break;
                case 5:
                    System.out.println("Program selesai.");
                    System.exit(0);
                    break;
                default:
                    System.out.println("Pilihan tidak valid.");
            }
        }
    }
}
