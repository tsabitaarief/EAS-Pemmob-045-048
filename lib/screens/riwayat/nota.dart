import 'package:flutter/material.dart'; // Mengimpor library Flutter Material untuk penggunaan widget dan komponen UI.
import 'package:aplikasirental_ps/constants.dart'; // Mengimpor file constants.dart yang berisi definisi warna dan nilai konstan aplikasi.

class NotaPage extends StatelessWidget { // Kelas NotaPage yang merupakan StatelessWidget untuk menampilkan halaman Nota.
  final String invoice; // Variabel untuk menyimpan nomor invoice.
  final String nama; // Variabel untuk menyimpan nama peminjam.
  final List<String> barang; // Variabel untuk menyimpan daftar barang yang dipinjam.
  final String tanggal; // Variabel untuk menyimpan tanggal peminjaman.
  final String waktu; // Variabel untuk menyimpan waktu peminjaman.
  final List<int> durasi; // Variabel untuk menyimpan durasi peminjaman setiap barang dalam hari.
  final int tarif; // Variabel untuk menyimpan total tarif peminjaman.

  NotaPage({ // Konstruktor untuk menginisialisasi nilai variabel saat pembuatan objek NotaPage.
    required this.invoice, // Parameter wajib untuk nomor invoice.
    required this.nama, // Parameter wajib untuk nama peminjam.
    required this.barang, // Parameter wajib untuk daftar barang.
    required this.tanggal, // Parameter wajib untuk tanggal peminjaman.
    required this.waktu, // Parameter wajib untuk waktu peminjaman.
    required this.durasi, // Parameter wajib untuk durasi peminjaman.
    required this.tarif, // Parameter wajib untuk total tarif.
  });

  @override
  Widget build(BuildContext context) { // Method build yang menampilkan UI dari NotaPage.
    return Scaffold( // Scaffold sebagai kerangka utama halaman Nota.
      appBar: AppBar( // AppBar sebagai bagian atas halaman.
        title: Text('Nota', style: TextStyle(color: Colors.white)), // Judul AppBar dengan teks 'Nota' berwarna putih.
        backgroundColor: PrimaryColor, // Warna latar belakang AppBar diambil dari PrimaryColor yang diimpor dari constants.dart.
        automaticallyImplyLeading: false, // Menonaktifkan tombol back di AppBar.
      ),
      body: Padding( // Padding sebagai pembungkus konten utama dalam body.
        padding: const EdgeInsets.all(16.0), // Padding dengan jarak 16.0 pada semua sisi.
        child: Container( // Container untuk mengatur tata letak dan gaya visual.
          padding: EdgeInsets.all(16.0), // Padding dalam Container dengan jarak 16.0 pada semua sisi.
          decoration: BoxDecoration( // BoxDecoration untuk memberikan efek bayangan dan border-radius.
            color: Colors.white, // Warna latar belakang Container putih.
            borderRadius: BorderRadius.circular(10), // BorderRadius untuk sudut Container menjadi bulat dengan radius 10.
            boxShadow: [ // Efek bayangan untuk Container.
              BoxShadow( // Bayangan dengan warna abu-abu, penyebaran 5, dan blur 7.
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // Mengubah posisi bayangan.
              ),
            ],
          ),
          child: Column( // Column untuk menampilkan konten secara vertikal.
            crossAxisAlignment: CrossAxisAlignment.center, // Menyusun elemen secara tengah secara horizontal.
            children: [
              Text( // Widget untuk menampilkan nomor invoice.
                'Invoice: $invoice', // Teks 'Invoice: ' diikuti dengan nomor invoice yang diterima dari parameter.
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Gaya teks dengan ukuran 20 dan tebal.
              ),
              Divider(color: Colors.grey, thickness: 1), // Pembatas horizontal abu-abu dengan ketebalan 1.
              SizedBox(height: 10), // Spasi kosong vertical setinggi 10.
              Text( // Widget untuk menampilkan nama peminjam.
                'Nama: $nama', // Teks 'Nama: ' diikuti dengan nama peminjam yang diterima dari parameter.
                style: TextStyle(fontSize: 18), // Gaya teks dengan ukuran 18.
              ),
              SizedBox(height: 10), // Spasi kosong vertical setinggi 10.
              Text( // Widget untuk menampilkan tanggal peminjaman.
                'Tanggal Peminjaman: $tanggal', // Teks 'Tanggal Peminjaman: ' diikuti dengan tanggal yang diterima dari parameter.
                style: TextStyle(fontSize: 18), // Gaya teks dengan ukuran 18.
              ),
              SizedBox(height: 10), // Spasi kosong vertical setinggi 10.
              Text( // Widget untuk menampilkan waktu peminjaman.
                'Waktu Peminjaman: $waktu', // Teks 'Waktu Peminjaman: ' diikuti dengan waktu yang diterima dari parameter.
                style: TextStyle(fontSize: 18), // Gaya teks dengan ukuran 18.
              ),
              SizedBox(height: 10), // Spasi kosong vertical setinggi 10.
              Text( // Widget untuk menampilkan durasi peminjaman total.
                'Durasi Peminjaman: ${durasi.reduce((a, b) => a + b)} Hari', // Teks 'Durasi Peminjaman: ' diikuti dengan total durasi dalam hari yang dihitung dari durasi masing-masing barang.
                style: TextStyle(fontSize: 18), // Gaya teks dengan ukuran 18.
              ),
              Divider(color: Colors.grey, thickness: 1), // Pembatas horizontal abu-abu dengan ketebalan 1.
              SizedBox(height: 10), // Spasi kosong vertical setinggi 10.
              Text( // Widget untuk menampilkan judul 'Barang:'.
                'Barang:', // Teks 'Barang:' dengan gaya teks tebal.
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Gaya teks dengan ukuran 18 dan tebal.
              ),
              SizedBox(height: 10), // Spasi kosong vertical setinggi 10.
              Expanded( // Expanded untuk membuat ListView bisa di-scroll jika kontennya melebihi ukuran layar.
                child: ListView.builder( // ListView.builder untuk menampilkan daftar barang yang dipinjam.
                  itemCount: barang.length, // Jumlah item sesuai dengan panjang list barang.
                  itemBuilder: (context, index) { // itemBuilder untuk membangun item pada ListView.
                    return ListTile( // ListTile untuk menampilkan setiap item dalam bentuk baris.
                      title: Text(barang[index]), // Judul ListTile berisi nama barang.
                      subtitle: Text('${durasi[index]} Hari'), // Subtitle ListTile berisi durasi peminjaman barang.
                    );
                  },
                ),
              ),
              Divider(color: Colors.grey, thickness: 1), // Pembatas horizontal abu-abu dengan ketebalan 1.
              SizedBox(height: 10), // Spasi kosong vertical setinggi 10.
              Text( // Widget untuk menampilkan total tarif peminjaman.
                'Total Tarif: Rp ${tarif.toStringAsFixed(0)}', // Teks 'Total Tarif: Rp ' diikuti dengan total tarif yang diterima dari parameter.
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Gaya teks dengan ukuran 18 dan tebal.
              ),
              SizedBox(height: 20), // Spasi kosong vertical setinggi 20.
              ElevatedButton( // Tombol ElevatedButton untuk kembali ke halaman sebelumnya.
                onPressed: () {
                  Navigator.pop(context); // Menggunakan Navigator.pop untuk kembali ke halaman sebelumnya.
                },
                style: ElevatedButton.styleFrom( // Gaya tombol dengan latar belakang PrimaryColor dan border SecondaryColor.
                  backgroundColor: PrimaryColor,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: SecondaryColor, width: 2),
                  ),
                ),
                child: Text( // Teks pada tombol 'Kembali' dengan warna putih dan ukuran 18.
                  'Kembali',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
