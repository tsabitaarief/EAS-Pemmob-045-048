import 'package:aplikasirental_ps/constants.dart'; // Mengimpor file constants.dart yang berisi konstanta-konstanta yang digunakan dalam aplikasi
import 'package:aplikasirental_ps/landingpage/masuk.dart'; // Mengimpor file masuk.dart yang berisi halaman login
import 'package:aplikasirental_ps/landingpage/welcomescreen.dart'; // Mengimpor file welcomescreen.dart yang berisi halaman sambutan
import 'package:flutter/material.dart'; // Mengimpor paket Flutter untuk membangun UI
import 'daftar.dart'; // Mengimpor file daftar.dart yang berisi halaman pendaftaran

class LogRegPage extends StatefulWidget {
  @override
  _LogRegPageState createState() => _LogRegPageState(); // Membuat state untuk LogRegPage
}

class _LogRegPageState extends State<LogRegPage> {
  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage(), // Navigasi ke halaman RegisterPage
      ),
    );
  }

  void _navigateToLogreg() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(), // Navigasi ke halaman LoginPage
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Mengambil ukuran layar perangkat saat ini
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'), // Mengatur judul AppBar
        centerTitle: true, // Mengatur judul AppBar agar berada di tengah
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Ikon untuk tombol kembali
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomeScreen(), // Navigasi ke halaman WelcomeScreen
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.1), // Memberi jarak vertikal 10% dari tinggi layar
            Center(
              child: Container(
                height: size.height * 0.3, // Mengatur tinggi gambar menjadi 30% dari tinggi layar
                width: size.width * 0.7, // Mengatur lebar gambar menjadi 70% dari lebar layar
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/logoaliblueps.png"), // Mengatur gambar logo
                    fit: BoxFit.contain, // Mengatur gambar agar sesuai dengan kontainer
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02), // Memberi jarak vertikal 2% dari tinggi layar
            Center(
              child: Text(
                'Selamat Datang di Aplikasi Rental PS',
                style: TextStyle(fontSize: 16), // Mengatur ukuran teks
                textAlign: TextAlign.center, // Mengatur teks agar berada di tengah
              ),
            ),
            SizedBox(height: size.height * 0.05), // Memberi jarak vertikal 5% dari tinggi layar
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _navigateToRegister, // Panggil fungsi _navigateToRegister saat kontainer diklik
                    child: Container(
                      width: size.width * 0.8, // Mengatur lebar kontainer menjadi 80% dari lebar layar
                      padding: EdgeInsets.symmetric(vertical: 15), // Mengatur padding vertikal
                      decoration: BoxDecoration(
                        border: Border.all(color: SecondaryColor, width: 2), // Mengatur border dengan warna sekunder dan lebar 2
                        borderRadius: BorderRadius.circular(10), // Mengatur border radius menjadi 10
                        color: PrimaryColor, // Mengatur warna latar belakang menjadi warna utama
                      ),
                      child: Center(
                        child: Text(
                          'Daftar',
                          style: TextStyle(color: Colors.white, fontSize: 18), // Mengatur warna teks menjadi putih dan ukuran teks
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // Memberi jarak vertikal 10px
                  GestureDetector(
                    onTap: _navigateToLogreg, // Panggil fungsi _navigateToLogreg saat kontainer diklik
                    child: Container(
                      width: size.width * 0.8, // Mengatur lebar kontainer menjadi 80% dari lebar layar
                      padding: EdgeInsets.symmetric(vertical: 15), // Mengatur padding vertikal
                      decoration: BoxDecoration(
                        border: Border.all(color: SecondaryColor, width: 2), // Mengatur border dengan warna sekunder dan lebar 2
                        borderRadius: BorderRadius.circular(10), // Mengatur border radius menjadi 10
                        color: PrimaryColor, // Mengatur warna latar belakang menjadi warna utama
                      ),
                      child: Center(
                        child: Text(
                          'Masuk',
                          style: TextStyle(color: Colors.white, fontSize: 18), // Mengatur warna teks menjadi putih dan ukuran teks
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
