import 'package:flutter/material.dart'; // Mengimpor library Flutter Material untuk penggunaan widget dan komponen UI.
import 'package:cloud_firestore/cloud_firestore.dart'; // Mengimpor Firebase Firestore untuk mengakses dan mengelola database cloud.
import 'package:intl/intl.dart'; // Mengimpor package intl untuk format tanggal dan waktu.
import 'package:aplikasirental_ps/constants.dart'; // Mengimpor file constants.dart yang berisi definisi warna dan nilai konstan aplikasi.
import 'package:aplikasirental_ps/screens/riwayat/nota.dart'; // Mengimpor halaman NotaPage untuk menampilkan detail transaksi.

class TransactionList extends StatelessWidget { // Kelas TransactionList yang merupakan StatelessWidget untuk menampilkan daftar transaksi.
  @override
  Widget build(BuildContext context) { // Method build untuk menampilkan UI dari TransactionList.
    return StreamBuilder<QuerySnapshot>( // Menggunakan StreamBuilder untuk mengambil data transaksi secara realtime dari Firestore.
      stream: FirebaseFirestore.instance.collection('transaksi').orderBy('timestamp', descending: true).snapshots(), // Mengambil data dari koleksi 'transaksi' yang diurutkan berdasarkan timestamp secara descending.
      builder: (context, snapshot) { // Builder untuk membangun UI berdasarkan snapshot data transaksi.
        if (snapshot.connectionState == ConnectionState.waiting) { // Jika koneksi sedang menunggu (loading), tampilkan indikator loading.
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) { // Jika terdapat error pada snapshot, tampilkan pesan error.
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) { // Jika snapshot tidak memiliki data atau dokumen kosong, tampilkan pesan tidak ada transaksi.
          return Center(child: Text('No transactions found'));
        }

        final transactions = snapshot.data!.docs; // Menyimpan list transaksi dari snapshot data.

        return ListView.builder( // ListView.builder untuk menampilkan daftar transaksi dalam bentuk list.
          itemCount: transactions.length, // Jumlah item sesuai dengan panjang list transaksi.
          itemBuilder: (context, index) { // itemBuilder untuk membangun setiap item dalam ListView.
            final transaction = transactions[index]; // Mengambil data transaksi pada indeks tertentu.
            final data = transaction.data() as Map<String, dynamic>; // Mengonversi data transaksi menjadi Map<String, dynamic>.

            // Memeriksa apakah data transaksi lengkap sebelum membangun kartu transaksi.
            if (_isTransactionDataComplete(data)) {
              return buildTransactionCard(context, transaction, data); // Memanggil method untuk membangun kartu transaksi.
            } else {
              return SizedBox.shrink(); // Merender elemen kosong jika data transaksi tidak lengkap.
            }
          },
        );
      },
    );
  }

  bool _isTransactionDataComplete(Map<String, dynamic> data) { // Method untuk memeriksa kelengkapan data transaksi.
    // Memastikan semua field yang diperlukan tidak null dan tidak kosong.
    return data['nama'] != null && data['nama'].toString().isNotEmpty &&
           data['barang'] != null && data['barang'] is List && (data['barang'] as List).isNotEmpty &&
           data['tanggal'] != null && data['tanggal'].toString().isNotEmpty &&
           data['durasi'] != null && data['durasi'].toString().isNotEmpty &&
           data['tarif'] != null && data['tarif'].toString().isNotEmpty;
  }

  Widget buildTransactionCard(BuildContext context, DocumentSnapshot transaction, Map<String, dynamic> data) { // Method untuk membangun kartu transaksi.
    return Card( // Mengembalikan widget Card untuk menampilkan detail transaksi.
      color: BackgroundColor2, // Warna latar belakang Card diambil dari BackgroundColor2 yang diimpor dari constants.dart.
      margin: EdgeInsets.all(10), // Margin 10 pada semua sisi Card.
      shape: RoundedRectangleBorder( // Mengatur bentuk sudut Card menjadi bulat dengan radius 10.
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding( // Padding di dalam Card untuk jarak antara konten dengan pinggir Card.
        padding: const EdgeInsets.all(10.0), // Padding 10 pada semua sisi.
        child: Column( // Column untuk menyusun konten secara vertikal.
          crossAxisAlignment: CrossAxisAlignment.start, // Menyusun elemen dari kiri ke kanan.
          children: [
            Text( // Widget untuk menampilkan nama peminjam.
              'Nama: ${data['nama']}', // Teks 'Nama: ' diikuti dengan nama peminjam dari data transaksi.
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Gaya teks dengan ukuran 18 dan tebal.
            ),
            SizedBox(height: 5), // Spasi kosong vertical setinggi 5.
            Text('Barang: ${data['barang'].join(', ')}'), // Widget untuk menampilkan daftar barang yang dipinjam.
            SizedBox(height: 5), // Spasi kosong vertical setinggi 5.
            Text('Tanggal Peminjaman: ${data['tanggal']}'), // Widget untuk menampilkan tanggal peminjaman.
            SizedBox(height: 5), // Spasi kosong vertical setinggi 5.
            Text('Durasi Peminjaman: ${data['durasi']} Hari'), // Widget untuk menampilkan durasi peminjaman.
            SizedBox(height: 5), // Spasi kosong vertical setinggi 5.
            Text('Tarif: Rp${data['tarif']}'), // Widget untuk menampilkan tarif peminjaman.
            SizedBox(height: 10), // Spasi kosong vertical setinggi 10.
            Row( // Row untuk menyusun tombol secara horizontal.
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Menyusun elemen tombol secara rata antara.
              children: [
                ElevatedButton( // Tombol ElevatedButton untuk melihat nota transaksi.
                  onPressed: () {
                    Navigator.push( // Navigasi ke halaman NotaPage dengan membawa data transaksi.
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotaPage(
                          invoice: data['invoice'], // Mengirimkan nomor invoice.
                          nama: data['nama'], // Mengirimkan nama peminjam.
                          barang: List<String>.from(data['barang']), // Mengirimkan daftar barang yang dipinjam.
                          tanggal: data['tanggal'], // Mengirimkan tanggal peminjaman.
                          waktu: DateFormat('HH:mm').format(data['timestamp'].toDate()), // Mengonversi timestamp menjadi format waktu HH:mm.
                          durasi: List<int>.from(data['durasi']), // Mengirimkan durasi peminjaman.
                          tarif: data['tarif'], // Mengirimkan tarif peminjaman.
                        ),
                      ),
                    );
                  },
                  child: Text('Cek Nota', style: TextStyle(color: Colors.white)), // Teks pada tombol 'Cek Nota' dengan warna putih.
                  style: ElevatedButton.styleFrom( // Gaya tombol dengan latar belakang BackgroundColor3 dan border SecondaryColor.
                    backgroundColor: BackgroundColor3,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: SecondaryColor, width: 2),
                    ),
                  ),
                ),
                ElevatedButton( // Tombol ElevatedButton untuk memindahkan transaksi ke proses ongoing.
                  onPressed: () {
                    _moveToOngoing(transaction); // Memanggil method untuk memindahkan transaksi ke proses ongoing.
                  },
                  child: Text('Ambil PS', style: TextStyle(color: Colors.white)), // Teks pada tombol 'Ambil PS' dengan warna putih.
                  style: ElevatedButton.styleFrom( // Gaya tombol dengan latar belakang BackgroundColor3 dan border SecondaryColor.
                    backgroundColor: BackgroundColor3,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: SecondaryColor, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _moveToOngoing(DocumentSnapshot transaction) { // Method untuk memindahkan transaksi ke proses ongoing.
    final data = transaction.data() as Map<String, dynamic>; // Mengambil data transaksi dari DocumentSnapshot.

    FirebaseFirestore.instance // Mengakses Firestore untuk memindahkan transaksi ke koleksi 'ongoing'.
        .collection('ongoing')
        .doc(transaction.id) // Menggunakan ID transaksi sebagai dokumen di koleksi 'ongoing'.
        .set(data) // Menyimpan data transaksi ke koleksi 'ongoing'.
        .then((_) {}) // Berhasil memindahkan transaksi.
        .catchError((error) { // Mengatasi error jika gagal memindahkan transaksi.
      print('Failed to move transaction: $error'); // Menampilkan pesan error ke konsol.
    });
  }
}
