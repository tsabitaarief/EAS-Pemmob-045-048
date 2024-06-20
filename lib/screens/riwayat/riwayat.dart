import 'package:aplikasirental_ps/screens/riwayat/tabriwayat/berjalan.dart'; // Mengimpor file berjalan.dart yang berisi definisi widget OngoingList untuk tab riwayat 'Sedang Berjalan'.
import 'package:aplikasirental_ps/screens/riwayat/tabriwayat/selesai.dart'; // Mengimpor file selesai.dart yang berisi definisi widget CompletedList untuk tab riwayat 'Sudah Selesai'.
import 'package:aplikasirental_ps/screens/riwayat/tabriwayat/transaksi.dart'; // Mengimpor file transaksi.dart yang berisi definisi widget TransactionList untuk tab riwayat 'Telah Dibayar'.
import 'package:flutter/material.dart'; // Mengimpor library Flutter Material untuk penggunaan widget dan komponen UI.
import 'package:aplikasirental_ps/constants.dart'; // Mengimpor file constants.dart yang berisi definisi warna dan nilai konstan aplikasi.

class HistoryScreen extends StatefulWidget { // Kelas HistoryScreen yang merupakan StatefulWidget untuk menangani state dinamis pada halaman riwayat transaksi.
  @override
  _HistoryScreenState createState() => _HistoryScreenState(); // Membuat state HistoryScreenState untuk HistoryScreen.
}

class _HistoryScreenState extends State<HistoryScreen> { // Kelas _HistoryScreenState yang merupakan State dari HistoryScreen.
  @override
  Widget build(BuildContext context) { // Method build yang menampilkan UI dari HistoryScreen.
    return DefaultTabController( // Menggunakan DefaultTabController untuk mengatur tab dengan panjang 3.
      length: 3,
      child: Scaffold( // Scaffold sebagai kerangka utama halaman.
        appBar: AppBar( // AppBar sebagai bagian atas halaman.
          title: Text('Riwayat Transaksi', style: TextStyle(color: Colors.white)), // Judul AppBar dengan teks 'Riwayat Transaksi' berwarna putih.
          backgroundColor: PrimaryColor, // Warna latar belakang AppBar diambil dari PrimaryColor yang diimpor dari constants.dart.
          automaticallyImplyLeading: false, // Menonaktifkan tombol back di AppBar.
          bottom: TabBar( // TabBar sebagai bagian bawah AppBar untuk menampilkan tab-tab.
            labelColor: Colors.white, // Warna teks label tab menjadi putih.
            tabs: [
              Tab(text: 'Telah Dibayar'), // Tab pertama dengan teks 'Telah Dibayar'.
              Tab(text: 'Sedang Berjalan'), // Tab kedua dengan teks 'Sedang Berjalan'.
              Tab(text: 'Sudah Selesai'), // Tab ketiga dengan teks 'Sudah Selesai'.
            ],
          ),
        ),
        body: TabBarView( // TabBarView untuk menampilkan konten dari setiap tab.
          children: [
            TransactionList(), // Menampilkan TransactionList di tab 'Telah Dibayar'.
            OngoingList(), // Menampilkan OngoingList di tab 'Sedang Berjalan'.
            CompletedList(), // Menampilkan CompletedList di tab 'Sudah Selesai'.
          ],
        ),
      ),
    );
  }
}
