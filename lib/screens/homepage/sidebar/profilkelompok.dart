import 'package:flutter/material.dart';
import 'package:aplikasirental_ps/constants.dart'; // Import file constants.dart untuk mengakses warna tema aplikasi
import 'package:url_launcher/url_launcher.dart'; // Import package url_launcher untuk membuka website dan email
import 'navdrawer.dart'; // Import NavDrawer untuk menavigasi kembali ke menu utama

// Kelas ProfilKelompokPage adalah StatefulWidget yang menampilkan profil pengembang berdasarkan list ProfilKelompok
class ProfilKelompokPage extends StatefulWidget {
  final List<ProfilKelompok> profiles; // List profil kelompok yang akan ditampilkan

  ProfilKelompokPage({required this.profiles}); // Constructor untuk menerima list profil

  @override
  _ProfilKelompokPageState createState() => _ProfilKelompokPageState();
}

class _ProfilKelompokPageState extends State<ProfilKelompokPage> {
  // Fungsi untuk membuka website berdasarkan URL
  _launchWebsite(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Fungsi untuk membuka aplikasi email dengan alamat email yang dituju
  _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pengembang', style: TextStyle(color: Colors.white)),
        backgroundColor: PrimaryColor, // Warna latar belakang app bar dari constants.dart
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NavDrawer(), // Menggunakan NavDrawer untuk kembali ke menu utama
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: widget.profiles.map((profile) { // Memetakan setiap profil ke dalam widget
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage(profile.assetImage), // Menampilkan gambar profil
                      ),
                      SizedBox(height: 16),
                      Text(
                        profile.nama, // Menampilkan nama lengkap
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        profile.birthPlace, // Menampilkan tempat lahir
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        profile.birthDate, // Menampilkan tanggal lahir
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        profile.address, // Menampilkan alamat lengkap
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        profile.phoneNumber, // Menampilkan nomor telepon
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        profile.npm, // Menampilkan NPM
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => _launchEmail(profile.email), // Memanggil fungsi untuk membuka email
                        child: Text(
                          profile.email, // Menampilkan alamat email
                          style: TextStyle(
                            fontSize: 16,
                            color: PriceTextColor, // Warna teks dari constants.dart
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => _launchWebsite(profile.github), // Memanggil fungsi untuk membuka website
                        child: Text(
                          profile.github, // Menampilkan URL GitHub
                          style: TextStyle(
                            fontSize: 16,
                            color: PriceTextColor, // Warna teks dari constants.dart
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

// Kelas ProfilKelompok merepresentasikan profil seorang pengembang
class ProfilKelompok {
  String assetImage; // Path gambar profil
  String nama; // Nama lengkap
  String birthPlace; // Tempat lahir
  String birthDate; // Tanggal lahir
  String address; // Alamat lengkap
  String phoneNumber; // Nomor telepon
  String npm; // Nomor Pokok Mahasiswa (NPM)
  String email; // Alamat email
  String github; // Akun GitHub

  // Constructor dengan parameter opsional untuk setiap atribut
  ProfilKelompok({
    this.assetImage = '',
    this.nama = '',
    this.birthPlace = '',
    this.birthDate = '',
    this.address = '',
    this.phoneNumber = '',
    this.npm = '',
    this.email = '',
    this.github = '',
  });

  // List static berisi contoh profil-profil kelompok
  static List<ProfilKelompok> profiles = [
    ProfilKelompok(
      assetImage: 'assets/profilcyn.jpeg',
      nama: 'Cynthia Widya Lestari',
      birthPlace: 'Sidoarjo',
      birthDate: '21 Juli 2004',
      address: 'Desa Medalem, Kec.Tulangan, Kab.Sidoarjo',
      phoneNumber: '085233671571',
      npm: '22082010045',
      email: '22082010045@student.upnjatim.ac.id',
      github: 'https://github.com/cynthiawidyaa',
    ),
    ProfilKelompok(
      assetImage: 'assets/profilputi.jpg',
      nama: 'Puti Tsabita Najwa Arief',
      birthPlace: 'Surabaya',
      birthDate: '31 Mei 2003',
      address: 'Jatisrono Timur, Kec. Semampir, Kota Surabaya',
      phoneNumber: '087862497402',
      npm: '22082010048',
      email: '22082010048@student.upnjatim.ac.id',
      github: 'https://github.com/tsabitaarief',
    ),
  ];
}
