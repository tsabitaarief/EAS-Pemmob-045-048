import 'package:flutter/material.dart'; // Import Flutter Material library untuk komponen UI
import 'package:aplikasirental_ps/constants.dart'; // Import file constants.dart yang berisi konstanta seperti PrimaryColor, SecondaryColor, dll.
import 'package:aplikasirental_ps/landingpage/logreg.dart'; // Import file logreg.dart untuk navigasi ke halaman login/registrasi
import 'package:aplikasirental_ps/screens/profil/editprofil.dart'; // Import file EditProfileScreen untuk navigasi ke halaman edit profil

class UserProfileScreen extends StatelessWidget {
  final String expectedName = 'Fajar Sadboy'; // Nama default
  final String expectedUsn = 'user123'; // Username default

  final String updatedName; // Variabel untuk menyimpan nama yang diperbarui
  final String updatedUsn; // Variabel untuk menyimpan username yang diperbarui

  UserProfileScreen({Key? key, required this.updatedName, required this.updatedUsn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String displayedName = updatedName.isNotEmpty ? updatedName : expectedName; // Menampilkan nama yang baru jika ada, jika tidak, tampilkan nama default
    String displayedUsn = updatedUsn.isNotEmpty ? updatedUsn : expectedUsn; // Menampilkan username yang baru jika ada, jika tidak, tampilkan username default

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pengguna', style: TextStyle(color: Colors.white)), // Judul AppBar
        backgroundColor: PrimaryColor, // Warna latar belakang AppBar
        automaticallyImplyLeading: false, // Menonaktifkan tombol back default di AppBar
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding konten utama
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/fajar.jpg'), // Gambar profil dalam CircleAvatar
              ),
              SizedBox(height: 16), // Spacer vertical
              Text(
                'Nama Lengkap : $displayedName', // Tampilkan nama yang diperbarui atau default
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Style teks nama
              ),
              SizedBox(height: 8), // Spacer vertical
              Text(
                'Username : $displayedUsn', // Tampilkan username yang diperbarui atau default
                style: TextStyle(fontSize: 24, color: PrimaryTextColor), // Style teks username
              ),
              SizedBox(height: 16), // Spacer vertical
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfileScreen()), // Navigasi ke halaman EditProfileScreen saat tombol Edit Profil ditekan
                  );
                },
                style: ElevatedButton.styleFrom( // Styling untuk tombol Edit Profil
                  backgroundColor: PrimaryColor, // Warna latar belakang tombol
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24), // Padding tombol
                  shape: RoundedRectangleBorder( // Bentuk tombol
                    borderRadius: BorderRadius.circular(10), // BorderRadius untuk sudut melengkung
                    side: BorderSide(color: SecondaryColor, width: 2), // BorderSide untuk border
                  ),
                ),
                child: Text('Edit Profil', style: TextStyle(color: Colors.white)), // Label tombol Edit Profil
              ),
              SizedBox(height: 16), // Spacer vertical
              ElevatedButton(
                onPressed: () {}, // Fungsi belum diimplementasikan untuk tombol Pengaturan
                style: ElevatedButton.styleFrom( // Styling untuk tombol Pengaturan
                  backgroundColor: PrimaryColor, // Warna latar belakang tombol
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24), // Padding tombol
                  shape: RoundedRectangleBorder( // Bentuk tombol
                    borderRadius: BorderRadius.circular(10), // BorderRadius untuk sudut melengkung
                    side: BorderSide(color: SecondaryColor, width: 2), // BorderSide untuk border
                  ),
                ),
                child: Text('Pengaturan', style: TextStyle(color: Colors.white)), // Label tombol Pengaturan
              ),
              SizedBox(height: 16), // Spacer vertical
              ElevatedButton(
                onPressed: () {}, // Fungsi belum diimplementasikan untuk tombol Umpan Balik
                style: ElevatedButton.styleFrom( // Styling untuk tombol Umpan Balik
                  backgroundColor: PrimaryColor, // Warna latar belakang tombol
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24), // Padding tombol
                  shape: RoundedRectangleBorder( // Bentuk tombol
                    borderRadius: BorderRadius.circular(10), // BorderRadius untuk sudut melengkung
                    side: BorderSide(color: SecondaryColor, width: 2), // BorderSide untuk border
                  ),
                ),
                child: Text('Umpan Balik', style: TextStyle(color: Colors.white)), // Label tombol Umpan Balik
              ),
              SizedBox(height: 16), // Spacer vertical
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogRegPage()), // Navigasi ke halaman LogRegPage saat tombol Log Out ditekan
                  );
                },
                style: ElevatedButton.styleFrom( // Styling untuk tombol Log Out
                  backgroundColor: Colors.red, // Warna latar belakang tombol
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24), // Padding tombol
                  shape: RoundedRectangleBorder( // Bentuk tombol
                    borderRadius: BorderRadius.circular(10), // BorderRadius untuk sudut melengkung
                    side: BorderSide(color: SecondaryColor, width: 2), // BorderSide untuk border
                  ),
                ),
                child: Text('Log Out', style: TextStyle(color: Colors.white)), // Label tombol Log Out
              ),
            ],
          ),
        ),
      ),
    );
  }
}
