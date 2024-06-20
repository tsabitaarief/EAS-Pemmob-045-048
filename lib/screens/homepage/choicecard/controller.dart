import 'package:aplikasirental_ps/constants.dart'; // Mengimpor file constants.dart yang berisi konstanta-konstanta yang digunakan dalam aplikasi
import 'package:aplikasirental_ps/screens/detail/detailstik.dart'; // Mengimpor halaman detail stik
import 'package:aplikasirental_ps/screens/homepage/homepage.dart'; // Mengimpor halaman utama
import 'package:flutter/material.dart'; // Mengimpor paket Flutter untuk membangun UI

class PSStickPage extends StatelessWidget {
  // Daftar stik yang tersedia
  static final List<Map<String, dynamic>> stickTypes = [
    {
      'title': 'DualShock 4',
      'subtitle': 'Official PS4 controller',
      'image': 'assets/dualshock.jpg',
      'price1': 15000,
      'price2': 35000,
      'price3': 65000,
      'duration1': 1,
      'duration2': 3,
      'duration3': 5,
    },
    {
      'title': 'DualSense',
      'subtitle': 'Official PS5 controller',
      'image': 'assets/dualsense.jpg',
      'price1': 20000,
      'price2': 50000,
      'price3': 80000,
      'duration1': 1,
      'duration2': 2,
      'duration3': 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jenis-jenis Stick PS', style: TextStyle(color: Colors.white)), // Mengatur judul AppBar dengan teks berwarna putih
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
        itemCount: stickTypes.length, // Jumlah item dalam grid
        itemBuilder: (context, index) {
          return PSStickCard(
            imagePath: stickTypes[index]['image']!, // Menampilkan gambar dari path yang ditentukan
            title: stickTypes[index]['title']!, // Menampilkan judul stik
            subtitle: stickTypes[index]['subtitle']!, // Menampilkan subtitle stik
            price1: stickTypes[index]['price1'], // Menampilkan harga 1
            price2: stickTypes[index]['price2'], // Menampilkan harga 2
            price3: stickTypes[index]['price3'], // Menampilkan harga 3
            duration1: stickTypes[index]['duration1'], // Menampilkan durasi 1
            duration2: stickTypes[index]['duration2'], // Menampilkan durasi 2
            duration3: stickTypes[index]['duration3'], // Menampilkan durasi 3
          );
        },
      ),
    );
  }
}

class PSStickCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
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
              builder: (context) => DetailStik(
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
