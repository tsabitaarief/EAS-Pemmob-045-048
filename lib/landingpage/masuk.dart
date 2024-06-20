import 'package:aplikasirental_ps/constants.dart'; // Mengimpor file constants.dart yang berisi konstanta-konstanta yang digunakan dalam aplikasi
import 'package:aplikasirental_ps/landingpage/logreg.dart'; // Mengimpor file logreg.dart yang berisi halaman login dan registrasi
import 'package:aplikasirental_ps/screens/homepage/homepage.dart'; // Mengimpor file homepage.dart yang berisi halaman utama
import 'package:flutter/material.dart'; // Mengimpor paket Flutter untuk membangun UI

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState(); // Membuat state untuk LoginPage
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usnController = TextEditingController(); // Mengontrol input username
  final TextEditingController _passwordController = TextEditingController(); // Mengontrol input password

  void _login() {
    final String expectedUsn = 'user123'; // Username yang diharapkan
    final String expectedPassword = '123'; // Password yang diharapkan

    String enteredUsn = _usnController.text.trim(); // Mengambil dan memangkas input username
    String enteredPassword = _passwordController.text.trim(); // Mengambil dan memangkas input password

    if (enteredUsn == expectedUsn && enteredPassword == expectedPassword) {
      // Jika username dan password sesuai, navigasi ke MainScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(userId: "user_id"),
        ),
      );
    } else {
      // Jika username atau password salah, tampilkan dialog kesalahan
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Email atau password salah. Silakan coba lagi.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _usnController.dispose(); // Bersihkan controller username saat tidak digunakan lagi
    _passwordController.dispose(); // Bersihkan controller password saat tidak digunakan lagi
    super.dispose(); // Panggil dispose() dari superclass
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Mengambil ukuran layar perangkat saat ini
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor, // Mengatur warna latar belakang AppBar
        title: Text('Masuk', style: TextStyle(color: Colors.white)), // Mengatur judul AppBar dan warna teks
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Ikon untuk tombol kembali
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LogRegPage(), // Navigasi ke halaman LogRegPage
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0), // Mengatur padding seluruh sisi
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.1), // Memberi jarak vertikal 10% dari tinggi layar
            Container(
              height: size.height * 0.3, // Mengatur tinggi gambar menjadi 30% dari tinggi layar
              width: size.width * 0.7, // Mengatur lebar gambar menjadi 70% dari lebar layar
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/logoaliblueps.png"), // Mengatur gambar logo
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05), // Memberi jarak vertikal 5% dari tinggi layar
            // Input field untuk username
            TextField(
              controller: _usnController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: PrimaryColor, width: 2.0)),
                fillColor: PrimaryTextColor,
              ),
            ),
            SizedBox(height: 20), // Memberi jarak vertikal 20px
            // Input field untuk password
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: PrimaryColor, width: 2.0)),
                fillColor: PrimaryTextColor,
              ),
              obscureText: true, // Menyembunyikan teks input (password)
            ),
            SizedBox(height: 20), // Memberi jarak vertikal 20px
            GestureDetector(
              onTap: _login, // Panggil fungsi _login saat kontainer diklik
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
    );
  }
}
