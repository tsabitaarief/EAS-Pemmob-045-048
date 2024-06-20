import 'package:flutter/material.dart';  // Import framework Flutter untuk membangun UI
import 'package:aplikasirental_ps/constants.dart';  // Import file konstanta aplikasi
import 'package:aplikasirental_ps/screens/homepage/homepage.dart';  // Import halaman utama aplikasi

class QRCodePage extends StatelessWidget {
  final String invoice;  // Variabel untuk menyimpan nomor invoice
  final String nama;  // Variabel untuk menyimpan nama pelanggan
  final double totalPrice;  // Variabel untuk menyimpan total harga pemesanan

  // Constructor untuk menerima invoice, nama, dan total harga
  QRCodePage({required this.invoice, required this.nama, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    // Data QR Code yang akan ditampilkan
    final qrData = 'Invoice: $invoice\nNama: $nama\nTotal: Rp ${totalPrice.toStringAsFixed(0)}';
    
    // URL untuk menghasilkan QR Code menggunakan API
    final qrUrl = 'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=$qrData';

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Tagihan', style: TextStyle(color: Colors.white)),
        backgroundColor: PrimaryColor,  // Menggunakan warna utama dari file konstanta
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Kembali ke halaman sebelumnya saat tombol kembali ditekan
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menampilkan gambar QR Code dari URL yang sudah dibuat
            Image.network(qrUrl),
            SizedBox(height: 20),
            Text(
              'Scan QR Code untuk detail tagihan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Menampilkan detail invoice, nama, dan total harga
            Text(
              'Invoice: $invoice',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Nama: $nama',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Total: Rp ${totalPrice.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 36),
            // Tombol untuk menyelesaikan dan kembali ke halaman utama
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(userId: 'user_id',),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PrimaryColor,  // Menggunakan warna utama dari file konstanta
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: SecondaryColor, width: 2),  // Menggunakan warna sekunder dari file konstanta
                ),
              ),
              child: Text(
                'Selesai',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
