import 'package:aplikasirental_ps/constants.dart'; // Mengimpor file constants.dart yang berisi konstanta-konstanta yang digunakan dalam aplikasi
import 'package:aplikasirental_ps/landingpage/logreg.dart'; // Mengimpor file logreg.dart yang berisi halaman logreg
import 'package:aplikasirental_ps/screens/homepage/homepage.dart'; // Mengimpor file homepage.dart yang berisi halaman utama
import 'package:flutter/material.dart'; // Mengimpor paket Flutter untuk membangun UI

class RegisterPage extends StatefulWidget {
  @override
  _RegistPageState createState() => _RegistPageState(); // Membuat state untuk RegisterPage
}

class _RegistPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController(); // Kontroller untuk input nama lengkap
  final TextEditingController _usnController = TextEditingController(); // Kontroller untuk input username
  final TextEditingController _passwordController = TextEditingController(); // Kontroller untuk input password
  final TextEditingController _passwordController2 = TextEditingController(); // Kontroller untuk input konfirmasi password

  void _signup() {
    final String expectedName = 'Fajar Sadboy'; // Nama yang diharapkan untuk validasi
    final String expectedUsn = 'user123'; // Username yang diharapkan untuk validasi
    final String expectedPassword = '123'; // Password yang diharapkan untuk validasi
    final String expectedPassword2 = '123'; // Konfirmasi password yang diharapkan untuk validasi

    String enteredName = _nameController.text.trim(); // Mengambil input nama dari pengguna
    String enteredUsn = _usnController.text.trim(); // Mengambil input username dari pengguna
    String enteredPassword = _passwordController.text.trim(); // Mengambil input password dari pengguna
    String enteredPassword2 = _passwordController2.text.trim(); // Mengambil input konfirmasi password dari pengguna

    if (enteredName == expectedName && enteredUsn == expectedUsn && enteredPassword == expectedPassword && enteredPassword2 == expectedPassword2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(userId: "user_id"), // Navigasi ke halaman utama jika input valid
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Email atau password tidak valid. Silakan coba lagi.'), // Menampilkan dialog kesalahan jika input tidak valid
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Menutup dialog kesalahan
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
    _usnController.dispose(); // Membersihkan kontroller username saat widget dibuang
    _passwordController.dispose(); // Membersihkan kontroller password saat widget dibuang
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Mengambil ukuran layar perangkat saat ini
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor, // Mengatur warna latar belakang AppBar
        title: Text('Daftar', style: TextStyle(color: Colors.white),), // Mengatur judul AppBar
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
        padding: EdgeInsets.all(20.0), // Mengatur padding di sekitar konten
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
            TextField(
              controller: _nameController, // Menghubungkan kontroller dengan input nama
              decoration: InputDecoration(
                labelText: 'Nama Lengkap', // Label untuk input nama
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: PrimaryColor, width: 2.0), // Mengatur border dengan warna utama dan lebar 2
                ),
                fillColor: PrimaryTextColor // Mengatur warna teks
              ),
            ),
            SizedBox(height: 20), // Memberi jarak vertikal 20px
            TextField(
              controller: _usnController, // Menghubungkan kontroller dengan input username
              decoration: InputDecoration(
                labelText: 'Username', // Label untuk input username
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: PrimaryColor, width: 2.0), // Mengatur border dengan warna utama dan lebar 2
                ),
                fillColor: PrimaryTextColor // Mengatur warna teks
              ),
            ),
            SizedBox(height: 20), // Memberi jarak vertikal 20px
            TextField(
              controller: _passwordController, // Menghubungkan kontroller dengan input password
              decoration: InputDecoration(
                labelText: 'Password', // Label untuk input password
                border: OutlineInputBorder(), // Mengatur border standar
                fillColor: PrimaryTextColor // Mengatur warna teks
              ),
              obscureText: true, // Mengatur teks input agar tidak terlihat (password)
            ),
            SizedBox(height: 20), // Memberi jarak vertikal 20px
            TextField(
              controller: _passwordController2, // Menghubungkan kontroller dengan input konfirmasi password
              decoration: InputDecoration(
                labelText: 'Konfirmasi Password', // Label untuk input konfirmasi password
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: PrimaryColor, width: 2.0), // Mengatur border dengan warna utama dan lebar 2
                ),
                fillColor: PrimaryTextColor // Mengatur warna teks
              ),
              obscureText: true, // Mengatur teks input agar tidak terlihat (password)
            ),
            SizedBox(height: 20), // Memberi jarak vertikal 20px
            GestureDetector(
              onTap: _signup, // Memanggil fungsi _signup saat kontainer diklik
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
                    'Daftar', // Teks pada tombol
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
