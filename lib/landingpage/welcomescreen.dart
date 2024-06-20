import 'package:aplikasirental_ps/constants.dart'; // Mengimpor file constants.dart yang berisi konstanta-konstanta yang digunakan dalam aplikasi
import 'package:flutter/material.dart'; // Mengimpor paket Flutter untuk membangun UI
import 'logreg.dart'; // Mengimpor file logreg.dart yang berisi halaman login dan registrasi

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Mengambil ukuran layar perangkat saat ini
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.1), // Memberi jarak vertikal 10% dari tinggi layar
              Container(
                height: size.height * 0.3, // Mengatur tinggi gambar menjadi 30% dari tinggi layar
                width: size.width * 0.7, // Mengatur lebar gambar menjadi 70% dari lebar layar
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/logoaliblueps.png"), // Mengatur gambar logo
                    fit: BoxFit.contain, // Mengatur gambar agar sesuai dengan kontainer
                  ),
                ),
              ),
              Text(
                "Welcome to AliBlue PS",
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Mengatur teks menjadi tebal
                  fontSize: 24, // Mengatur ukuran teks
                ),
                textAlign: TextAlign.center, // Mengatur teks agar berada di tengah
              ),
              Text(
                "Find and rent your desired PS Console easily",
                style: TextStyle(
                  fontSize: 16, // Mengatur ukuran teks
                ),
                textAlign: TextAlign.center, // Mengatur teks agar berada di tengah
              ),
              SizedBox(height: size.height * 0.05), // Memberi jarak vertikal 5% dari tinggi layar
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LogRegPage(), // Navigasi ke halaman LogRegPage
                    ),
                  );
                },
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
                      'Get Started',
                      style: TextStyle(color: Colors.white, fontSize: 18), // Mengatur warna teks menjadi putih dan ukuran teks
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
