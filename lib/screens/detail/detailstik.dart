import 'package:flutter/material.dart';
import 'package:aplikasirental_ps/constants.dart'; // Import file constants.dart untuk mengakses konstanta warna
import 'package:aplikasirental_ps/screens/homepage/choicecard/controller.dart'; // Import file controller.dart untuk mengakses PSStickPage
import 'package:aplikasirental_ps/screens/keranjang/keranjang.dart'; // Import file keranjang.dart untuk mengakses CartScreen
import 'package:provider/provider.dart'; // Import package provider untuk manajemen state

// Kelas DetailStik adalah StatefulWidget yang menampilkan detail stik controller
class DetailStik extends StatefulWidget {
  final String imagePath; // Path gambar stik controller
  final String title; // Judul stik controller
  final String subtitle; // Subjudul atau deskripsi stik controller
  final int price1; // Harga opsi 1
  final int price2; // Harga opsi 2
  final int price3; // Harga opsi 3
  final int duration1; // Durasi sewa opsi 1 (dalam hari)
  final int duration2; // Durasi sewa opsi 2 (dalam hari)
  final int duration3; // Durasi sewa opsi 3 (dalam hari)

  // Constructor untuk inisialisasi atribut yang diperlukan
  const DetailStik({
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
  _DetailStikState createState() => _DetailStikState();
}

// Kelas PriceDuration merepresentasikan harga dan durasi sewa opsi stik controller
class PriceDuration {
  final int price; // Harga sewa
  final int duration; // Durasi sewa dalam hari

  // Constructor dengan parameter harga dan durasi
  PriceDuration(this.price, this.duration);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PriceDuration &&
        other.price == price &&
        other.duration == duration;
  }

  @override
  int get hashCode => price.hashCode ^ duration.hashCode;
}

// _DetailStikState adalah State class untuk DetailStik
class _DetailStikState extends State<DetailStik> {
  PriceDuration? selectedPriceDuration; // Variabel untuk menyimpan harga dan durasi yang dipilih

  // initState digunakan untuk inisialisasi nilai awal saat state pertama kali dibuat
  @override
  void initState() {
    super.initState();
    selectedPriceDuration = PriceDuration(widget.price1, widget.duration1); // Menginisialisasi dengan harga dan durasi opsi 1
  }

  // build digunakan untuk membangun UI dari widget
  @override
  Widget build(BuildContext context) {
    final List<PriceDuration> priceDurations = [
      PriceDuration(widget.price1, widget.duration1), // Opsi harga dan durasi 1
      PriceDuration(widget.price2, widget.duration2), // Opsi harga dan durasi 2
      PriceDuration(widget.price3, widget.duration3), // Opsi harga dan durasi 3
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        backgroundColor: PrimaryColor, // Warna latar belakang app bar dari constants.dart
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PSStickPage(), // Kembali ke halaman PSStickPage
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath), // Menampilkan gambar stik controller
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.title, // Menampilkan judul stik controller
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: PrimaryTextColor, // Warna teks dari constants.dart
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Rp${selectedPriceDuration!.price}', // Menampilkan harga yang dipilih
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: PriceTextColor, // Warna teks dari constants.dart
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Tarif Sewa:', // Label untuk tarif sewa
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Column(
                children: priceDurations.map((priceDuration) {
                  return RadioListTile<PriceDuration>(
                    title: Text(
                        'Rp${priceDuration.price} (${priceDuration.duration} Hari)'), // Menampilkan opsi harga dan durasi
                    value: priceDuration,
                    groupValue: selectedPriceDuration,
                    onChanged: (value) {
                      setState(() {
                        selectedPriceDuration = value; // Mengubah harga dan durasi yang dipilih
                      });
                    },
                    activeColor: RadioColor, // Warna radio button aktif dari constants.dart
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedPriceDuration != null) {
                      // Menambahkan item stik controller yang dipilih ke dalam keranjang belanja
                      Item newItem = Item(
                        imagePath: widget.imagePath,
                        title: widget.title,
                        versi: widget.subtitle,
                        price: selectedPriceDuration!.price,
                        durasi: selectedPriceDuration!.duration,
                      );

                      Provider.of<CartProvider>(context, listen: false)
                          .addItem(newItem); // Menggunakan Provider untuk menambahkan item

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CartScreen()), // Navigasi ke halaman Keranjang
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PrimaryColor, // Warna tombol dari constants.dart
                    padding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: SecondaryColor, width: 2), // Warna border dari constants.dart
                    ),
                  ),
                  child: Text(
                    'Masukkan Keranjang',
                    style: TextStyle(color: Colors.white),
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
