import 'package:flutter/material.dart'; // Import Flutter Material library untuk komponen UI
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore untuk mengakses database Firestore
import 'package:intl/intl.dart'; // Import package intl untuk formatting tanggal
import 'package:aplikasirental_ps/constants.dart'; // Import file constants.dart yang berisi konstanta seperti BackgroundColor2, BackgroundColor3, dan SecondaryColor
import 'package:aplikasirental_ps/screens/riwayat/nota.dart'; // Import file nota.dart untuk navigasi ke halaman detail nota

class CompletedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('completed').snapshots(), // Stream dari koleksi 'completed' di Firestore
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Tampilkan indikator loading jika snapshot sedang dalam proses pengambilan data
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Tampilkan pesan error jika terjadi kesalahan
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No completed transactions found')); // Tampilkan pesan jika tidak ada transaksi yang selesai
        }

        final completedTransactions = snapshot.data!.docs; // Ambil data dokumen dari snapshot

        return ListView.builder(
          itemCount: completedTransactions.length,
          itemBuilder: (context, index) {
            final completedTransaction = completedTransactions[index];
            final data = completedTransaction.data() as Map<String, dynamic>; // Ambil data transaksi selesai

            if (_isTransactionDataComplete(data)) {
              return buildCompletedCard(context, completedTransaction, data); // Bangun kartu transaksi selesai jika data lengkap
            } else {
              return SizedBox.shrink(); // Render kosong jika data tidak lengkap
            }
          },
        );
      },
    );
  }

  bool _isTransactionDataComplete(Map<String, dynamic> data) {
    // Fungsi untuk memeriksa kelengkapan data transaksi
    return data['nama'] != null && data['nama'].toString().isNotEmpty &&
           data['barang'] != null && data['barang'] is List && (data['barang'] as List).isNotEmpty &&
           data['tanggal'] != null && data['tanggal'].toString().isNotEmpty &&
           data['durasi'] != null && data['durasi'].toString().isNotEmpty &&
           data['tarif'] != null && data['tarif'].toString().isNotEmpty;
  }

  Widget buildCompletedCard(BuildContext context, DocumentSnapshot completedTransaction, Map<String, dynamic> data) {
    return Card(
      color: BackgroundColor2, // Warna latar belakang kartu dari constants.dart
      margin: EdgeInsets.all(10), // Margin kartu
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Sudut melengkung untuk kartu
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0), // Padding konten dalam kartu
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama: ${data['nama']}', // Tampilkan nama dari data transaksi
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold), // Style teks nama
            ),
            SizedBox(height: 5), // Spacer vertical
            Text('Barang: ${data['barang'].join(', ')}'), // Tampilkan barang dari data transaksi
            SizedBox(height: 5), // Spacer vertical
            Text('Tanggal Peminjaman: ${data['tanggal']}'), // Tampilkan tanggal peminjaman dari data transaksi
            SizedBox(height: 5), // Spacer vertical
            Text('Durasi Peminjaman: ${data['durasi']} Hari'), // Tampilkan durasi peminjaman dari data transaksi
            SizedBox(height: 5), // Spacer vertical
            Text('Tarif: Rp${data['tarif']}'), // Tampilkan tarif dari data transaksi
            SizedBox(height: 10), // Spacer vertical
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotaPage(
                      invoice: data['invoice'],
                      nama: data['nama'],
                      barang: List<String>.from(data['barang']),
                      tanggal: data['tanggal'],
                      waktu: DateFormat('HH:mm')
                          .format(data['timestamp'].toDate()),
                      durasi: List<int>.from(data['durasi']),
                      tarif: data['tarif'],
                    ),
                  ),
                );
              },
              child: Text('Cek Nota',
                  style: TextStyle(color: Colors.white)), // Label tombol untuk cek nota
              style: ElevatedButton.styleFrom(
                backgroundColor: BackgroundColor3, // Warna latar belakang tombol dari constants.dart
                padding: EdgeInsets.symmetric(
                    vertical: 12, horizontal: 24), // Padding tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Sudut melengkung untuk tombol
                  side: BorderSide(color: SecondaryColor, width: 2), // BorderSide untuk border
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
