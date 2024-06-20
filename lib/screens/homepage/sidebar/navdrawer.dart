import 'package:aplikasirental_ps/constants.dart'; // Mengimpor file constants.dart yang berisi konstanta-konstanta yang digunakan dalam aplikasi
import 'package:aplikasirental_ps/screens/homepage/homepage.dart'; // Mengimpor halaman utama aplikasi
import 'package:aplikasirental_ps/screens/homepage/sidebar/profilkelompok.dart'; // Mengimpor halaman profil kelompok
import 'package:flutter/material.dart'; // Mengimpor paket Flutter untuk membangun UI

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mendapatkan profil pertama dan kedua dari kelas ProfilKelompok
    final firstProfile = ProfilKelompok.profiles[0];
    final secondProfile = ProfilKelompok.profiles[1];

    return Builder(
      builder: (context) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // Memberi padding nol di sekitar ListView
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent, // Mengatur warna latar belakang DrawerHeader menjadi transparan
                image: DecorationImage(
                  image: AssetImage('assets/logoaliblueps.png'), // Menampilkan gambar pada DrawerHeader
                  fit: BoxFit.fitHeight, // Menyesuaikan gambar dengan tinggi DrawerHeader
                ),
              ),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black), // Menampilkan ikon panah kembali berwarna hitam
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(
                              userId: 'user_id', // Navigasi ke halaman MainScreen dengan mengirimkan userId
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person), // Menampilkan ikon person di bagian leading ListTile
              title: Text(
                'Profil ${firstProfile.nama}', // Menampilkan teks profil dengan nama dari profil pertama
                style: TextStyle(color: PrimaryTextColor), // Mengatur warna teks berdasarkan konstanta PrimaryTextColor
              ),
              onTap: () {
                Navigator.of(context).pop(); // Menutup Drawer saat ListTile ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProfilKelompokPage(profiles: [firstProfile]), // Navigasi ke halaman ProfilKelompokPage dengan profil pertama
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person), // Menampilkan ikon person di bagian leading ListTile
              title: Text(
                'Profil ${secondProfile.nama}', // Menampilkan teks profil dengan nama dari profil kedua
                style: TextStyle(color: PrimaryTextColor), // Mengatur warna teks berdasarkan konstanta PrimaryTextColor
              ),
              onTap: () {
                Navigator.of(context).pop(); // Menutup Drawer saat ListTile ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProfilKelompokPage(profiles: [secondProfile]), // Navigasi ke halaman ProfilKelompokPage dengan profil kedua
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
