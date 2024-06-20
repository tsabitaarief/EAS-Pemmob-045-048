import 'package:aplikasirental_ps/constants.dart'; // Mengimpor file constants.dart yang berisi konstanta-konstanta yang digunakan dalam aplikasi
import 'package:aplikasirental_ps/screens/detail/detailps.dart'; // Mengimpor halaman detail PS
import 'package:aplikasirental_ps/screens/homepage/homepage.dart'; // Mengimpor halaman utama
import 'package:flutter/material.dart'; // Mengimpor paket Flutter untuk membangun UI

class PSPage extends StatelessWidget {
  // Daftar tipe-tipe PlayStation yang tersedia
  static final List<Map<String, dynamic>> psTypes = [
    {
      'title': 'PlayStation 5',
      'subtitle': 'PS 5 Digital Ver.',
      'image': 'assets/ps5digi.png',
      'price1': 225000,
      'price2': 600000,
      'price3': 1000000,
      'duration1': 1,
      'duration2': 3,
      'duration3': 5
    },
    {
      'title': 'PlayStation 5',
      'subtitle': 'PS 5 Disc Ver.',
      'image': 'assets/ps5disc.png',
      'price1': 225000,
      'price2': 600000,
      'price3': 1000000,
      'duration1': 1,
      'duration2': 3,
      'duration3': 5
    },
    {
      'title': 'PlayStation 4',
      'subtitle': 'PS 4 Slim Ver.',
      'image': 'assets/ps4slim.png',
      'price1': 125000,
      'price2': 300000,
      'price3': 550000,
      'duration1': 1,
      'duration2': 3,
      'duration3': 5
    },
    {
      'title': 'PlayStation 4',
      'subtitle': 'PS 4 Fat Ver.',
      'image': 'assets/ps4fat.png',
      'price1': 125000,
      'price2': 300000,
      'price3': 550000,
      'duration1': 1,
      'duration2': 3,
      'duration3': 5
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jenis-jenis PS', style: TextStyle(color: Colors.white)), // Mengatur judul AppBar dengan teks berwarna putih
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
        itemCount: psTypes.length, // Jumlah item dalam grid
        itemBuilder: (context, index) {
          return PSCard(
            imagePath: psTypes[index]['image']!, // Menampilkan gambar dari path yang ditentukan
            title: psTypes[index]['title']!, // Menampilkan judul PS
            subtitle: psTypes[index]['subtitle']!, // Menampilkan subtitle PS
            price1: psTypes[index]['price1'], // Menampilkan harga 1
            price2: psTypes[index]['price2'], // Menampilkan harga 2
            price3: psTypes[index]['price3'], // Menampilkan harga 3
            duration1: psTypes[index]['duration1'], // Menampilkan durasi 1
            duration2: psTypes[index]['duration2'], // Menampilkan durasi 2
            duration3: psTypes[index]['duration3'], // Menampilkan durasi 3
          );
        },
      ),
    );
  }
}

class PSCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final int price1;
  final int price2;
  final int price3;
  final int duration1;
  final int duration2;
  final int duration3;

  const PSCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
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
              builder: (context) => DetailPS(
                imagePath: imagePath,
                title: title,
                subtitle: subtitle,
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
                      fit: BoxFit.cover, // Menyesuaikan gambar dengan ukuran container
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
                  color: PrimaryTextColor, // Warna teks judul
                ),
              ),
              Text(
                subtitle,
                maxLines: 2, // Menampilkan maksimal 2 baris teks
                overflow: TextOverflow.ellipsis, // Menampilkan elipsis jika teks terlalu panjang
                style: TextStyle(
                  color: SecondaryTextColor, // Warna teks subjudul
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
