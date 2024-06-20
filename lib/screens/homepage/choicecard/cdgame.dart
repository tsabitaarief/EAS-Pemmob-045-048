import 'package:aplikasirental_ps/constants.dart'; // Mengimpor file constants.dart yang berisi konstanta-konstanta yang digunakan dalam aplikasi
import 'package:aplikasirental_ps/screens/detail/detailgame.dart'; // Mengimpor halaman detail game
import 'package:aplikasirental_ps/screens/homepage/homepage.dart'; // Mengimpor halaman utama
import 'package:flutter/material.dart'; // Mengimpor paket Flutter untuk membangun UI

class PSGamePage extends StatelessWidget {
  // Daftar game yang tersedia
  static final List<Map<String, dynamic>> gameTypes = [
    {
      'title': 'The Quarry',
      'versi1': 'PS 4',
      'versi2': 'PS 5',
      'image': 'assets/quarry.jpg',
      'price1': 6000,
      'price2': 15000,
      'price3': 20000,
      'duration1': 1,
      'duration2': 3,
      'duration3': 5,
    },
    {
      'title': 'Detroit Become Human',
      'versi1': 'PS 4',
      'versi2': 'PS 5',
      'image': 'assets/dbh.jpg',
      'price1': 6000,
      'price2': 15000,
      'price3': 20000,
      'duration1': 1,
      'duration2': 3,
      'duration3': 5,
    },
    {
      'title': 'Resident Evil Village',
      'versi1': 'PS 4',
      'versi2': 'PS 5',
      'image': 'assets/revillage.png',
      'price1': 6000,
      'price2': 15000,
      'price3': 20000,
      'duration1': 1,
      'duration2': 3,
      'duration3': 5,
    },
    {
      'title': 'Resident Evil 4 Remake',
      'versi1': 'PS 4',
      'versi2': 'PS 5',
      'image': 'assets/re4r.jpg',
      'price1': 6000,
      'price2': 15000,
      'price3': 20000,
      'duration1': 1,
      'duration2': 3,
      'duration3': 5,
    },
    {
      'title': 'GTA V',
      'versi1': 'PS 4',
      'versi2': 'PS 5',
      'image': 'assets/gtav.jpg',
      'price1': 6000,
      'price2': 15000,
      'price3': 20000,
      'duration1': 1,
      'duration2': 3,
      'duration3': 5,
    },
    {
      'title': 'It Takes Two',
      'versi1': 'PS 4',
      'versi2': 'PS 5',
      'image': 'assets/ittwo.png',
      'price1': 6000,
      'price2': 15000,
      'price3': 20000,
      'duration1': 1,
      'duration2': 3,
      'duration3': 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jenis-jenis Game PS', style: TextStyle(color: Colors.white)), // Mengatur judul AppBar dengan teks berwarna putih
        backgroundColor: PrimaryColor, // Mengatur warna latar belakang AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Mengatur ikon kembali dengan warna putih
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(userId: 'user_id',), // Navigasi ke halaman MainScreen
              ),
            );
          },
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8), // Memberikan padding sebesar 8 di sekitar grid
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Jumlah kolom dalam grid
          crossAxisSpacing: 8, // Jarak antar kolom
          mainAxisSpacing: 8, // Jarak antar baris
        ),
        itemCount: gameTypes.length, // Jumlah item dalam grid
        itemBuilder: (context, index) {
          final game = gameTypes[index];
          return PSStickCard(
            imagePath: game['image']!, // Menampilkan gambar dari path yang ditentukan
            title: game['title']!, // Menampilkan judul game
            versi1: game['versi1'], // Menampilkan versi 1 game
            versi2: game['versi2']!, // Menampilkan versi 2 game
            price1: game['price1']!, // Menampilkan harga 1
            price2: game['price2']!, // Menampilkan harga 2
            price3: game['price3']!, // Menampilkan harga 3
            duration1: game['duration1']!, // Menampilkan durasi 1
            duration2: game['duration2']!, // Menampilkan durasi 2
            duration3: game['duration3']!, // Menampilkan durasi 3
          );
        },
      ),
    );
  }
}

class PSStickCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String versi1;
  final String versi2;
  final int price1;
  final int price2;
  final int price3;
  final int duration1;
  final int duration2;
  final int duration3;

  const PSStickCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.versi1,
    required this.versi2,
    required this.price1,
    required this.price2,
    required this.price3,
    required this.duration1,
    required this.duration2,
    required this.duration3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Membulatkan sudut kartu
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailGame(
                imagePath: imagePath,
                title: title,
                versi1: versi1,
                versi2: versi2,
                price1: price1,
                price2: price2,
                price3: price3,
                duration1: duration1,
                duration2: duration2,
                duration3: duration3
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Memberikan padding di sekitar konten kartu
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath), // Menampilkan gambar
                      fit: BoxFit.fitHeight, // Menyesuaikan gambar dengan ukuran container
                    ),
                    borderRadius: BorderRadius.circular(8), // Membulatkan sudut gambar
                  ),
                ),
              ),
              SizedBox(height: 8), // Memberi jarak vertikal 8px
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Menampilkan teks judul dengan huruf tebal
                ),
              ),
              Text(
                'PS4/PS5',
                maxLines: 2, // Menampilkan maksimal 2 baris teks
                overflow: TextOverflow.ellipsis, // Menampilkan elipsis jika teks terlalu panjang
                style: TextStyle(
                  color: Colors.grey, // Warna teks subjudul
                ),
              ),
              Text(
                'Rp$price1 - Rp$price3',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Menampilkan teks harga dengan huruf tebal
                  color: PriceTextColor, // Warna teks harga
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
