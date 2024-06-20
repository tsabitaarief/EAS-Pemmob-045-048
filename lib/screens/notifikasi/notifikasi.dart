import 'package:aplikasirental_ps/constants.dart';  // Import file konstanta aplikasi
import 'package:aplikasirental_ps/screens/homepage/homepage.dart';  // Import halaman utama aplikasi (HomePage)
import 'package:flutter/material.dart';  // Import framework Flutter untuk membangun UI
import 'package:cloud_firestore/cloud_firestore.dart';  // Import Firestore untuk mengakses dan mengelola database
import 'package:intl/intl.dart';  // Import package intl untuk formatting tanggal

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi', style: TextStyle(color: Colors.white)),
        backgroundColor: PrimaryColor,  // Menggunakan warna utama dari file konstanta
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(
                  userId: 'user_id',  // Melakukan navigasi kembali ke halaman utama dengan membawa parameter userId
                ),
              ),
            );
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notifikasi')
            .orderBy('timestamp', descending: true)
            .snapshots(),  // Mengambil data notifikasi dari Firestore secara realtime
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());  // Menampilkan indikator loading jika data sedang dimuat
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));  // Menampilkan pesan error jika terjadi kesalahan
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No notifications found'));  // Menampilkan pesan jika tidak ada data notifikasi yang ditemukan
          }
          final notifications = snapshot.data!.docs;  // Mendapatkan daftar dokumen notifikasi dari snapshot

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              final data = notification.data() as Map<String, dynamic>;  // Mendapatkan data notifikasi dari dokumen

              if (data['judul'] != null && data['judul'].isNotEmpty &&
                  data['pesan'] != null && data['pesan'].isNotEmpty) {
                return Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: PrimaryColor,  // Menggunakan warna utama dari file konstanta
                  child: Container(
                    decoration: BoxDecoration(
                      color: BackgroundColor2,  // Menggunakan warna latar belakang kedua dari file konstanta
                      borderRadius: BorderRadius.circular(15),  // Mengatur border radius untuk card
                    ),
                    child: ListTile(
                      title: Text(data['judul']),  // Judul notifikasi
                      subtitle: Text(data['pesan']),  // Isi pesan notifikasi
                      trailing: Text(
                        DateFormat('yyyy-MM-dd – kk:mm')  // Format tanggal notifikasi
                            .format(data['timestamp'].toDate()),
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                );
              }
              return SizedBox.shrink();  // Mengembalikan widget kosong jika data notifikasi tidak lengkap
            },
          );
        },
      ),
    );
  }
}
