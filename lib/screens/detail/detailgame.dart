import 'package:flutter/material.dart';
import 'package:aplikasirental_ps/constants.dart'; // Import file constants.dart untuk mengakses konstanta warna
import 'package:aplikasirental_ps/screens/homepage/choicecard/cdgame.dart'; // Import file cdgame.dart untuk mengakses PSGamePage
import 'package:aplikasirental_ps/screens/keranjang/keranjang.dart'; // Import file keranjang.dart untuk mengakses CartScreen
import 'package:provider/provider.dart'; // Import package provider untuk manajemen state

// Kelas DetailGame adalah StatefulWidget yang menampilkan detail permainan (game)
class DetailGame extends StatefulWidget {
  final String imagePath; // Path gambar permainan
  final String title; // Judul permainan
  final String versi1; // Versi permainan 1
  final String versi2; // Versi permainan 2
  final int price1; // Harga permainan versi 1
  final int price2; // Harga permainan versi 2
  final int price3; // Harga permainan versi 3
  final int duration1; // Durasi sewa permainan versi 1 (dalam hari)
  final int duration2; // Durasi sewa permainan versi 2 (dalam hari)
  final int duration3; // Durasi sewa permainan versi 3 (dalam hari)

  // Constructor untuk inisialisasi atribut yang diperlukan
  const DetailGame({
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
  _DetailPSState createState() => _DetailPSState();
}

// Kelas PriceDuration merepresentasikan harga dan durasi sewa permainan
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

// _DetailPSState adalah State class untuk DetailGame
class _DetailPSState extends State<DetailGame> {
  PriceDuration? selectedPriceDuration; // Variabel untuk menyimpan harga dan durasi yang dipilih
  String? selectedVersi; // Variabel untuk menyimpan versi permainan yang dipilih

  // initState digunakan untuk inisialisasi nilai awal saat state pertama kali dibuat
  @override
  void initState() {
    super.initState();
    selectedPriceDuration = PriceDuration(widget.price1, widget.duration1); // Menginisialisasi dengan versi dan harga awal
    selectedVersi = widget.versi1;
  }

  // build digunakan untuk membangun UI dari widget
  @override
  Widget build(BuildContext context) {
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
                builder: (context) => PSGamePage(), // Kembali ke halaman PSGamePage ketika tombol kembali ditekan
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
                    image: AssetImage(widget.imagePath), // Menampilkan gambar permainan
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.title, // Menampilkan judul permainan
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: PrimaryTextColor, // Warna teks dari constants.dart
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Rp${selectedPriceDuration!.price}/Hari', // Menampilkan harga sewa per hari
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
              SizedBox(height: 8),
              Text(
                'Versi :',
                style: TextStyle(fontSize: 16, color: PrimaryTextColor), // Warna teks dari constants.dart
              ),
              SizedBox(height: 8),
              Column(
                children: [
                  RadioListTile<String>(
                    title: Text('PS 4'),
                    value: widget.versi1,
                    groupValue: selectedVersi,
                    onChanged: (value) {
                      setState(() {
                        selectedVersi = value; // Mengubah versi yang dipilih
                      });
                    },
                    activeColor: RadioColor, // Warna radio button aktif dari constants.dart
                  ),
                  RadioListTile<String>(
                    title: Text('PS 5'),
                    value: widget.versi2,
                    groupValue: selectedVersi,
                    onChanged: (value) {
                      setState(() {
                        selectedVersi = value; // Mengubah versi yang dipilih
                      });
                    },
                    activeColor: RadioColor, // Warna radio button aktif dari constants.dart
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Tarif Sewa :',
                style: TextStyle(fontSize: 16, color: PrimaryTextColor), // Warna teks dari constants.dart
              ),
              SizedBox(height: 8),
              Column(
                children: [
                  RadioListTile<PriceDuration>(
                    title: Text('Rp${widget.price1} (${widget.duration1} Hari)'), // Menampilkan harga dan durasi permainan
                    value: PriceDuration(widget.price1, widget.duration1),
                    groupValue: selectedPriceDuration,
                    onChanged: (value) {
                      setState(() {
                        selectedPriceDuration = value; // Mengubah harga dan durasi yang dipilih
                      });
                    },
                    activeColor: RadioColor, // Warna radio button aktif dari constants.dart
                  ),
                  RadioListTile<PriceDuration>(
                    title: Text('Rp${widget.price2} (${widget.duration2} Hari)'),
                    value: PriceDuration(widget.price2, widget.duration2),
                    groupValue: selectedPriceDuration,
                    onChanged: (value) {
                      setState(() {
                        selectedPriceDuration = value; // Mengubah harga dan durasi yang dipilih
                      });
                    },
                    activeColor: RadioColor, // Warna radio button aktif dari constants.dart
                  ),
                  RadioListTile<PriceDuration>(
                    title: Text('Rp${widget.price3} (${widget.duration3} Hari)'),
                    value: PriceDuration(widget.price3, widget.duration3),
                    groupValue: selectedPriceDuration,
                    onChanged: (value) {
                      setState(() {
                        selectedPriceDuration = value; // Mengubah harga dan durasi yang dipilih
                      });
                    },
                    activeColor: RadioColor, // Warna radio button aktif dari constants.dart
                  ),
                ],
              ),
              SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Menambahkan item permainan yang dipilih ke dalam keranjang belanja
                    Item newItem = Item(
                      imagePath: widget.imagePath,
                      title: widget.title,
                      versi: selectedVersi!,
                      price: selectedPriceDuration!.price,
                      durasi: selectedPriceDuration!.duration,
                    );

                    Provider.of<CartProvider>(context, listen: false).addItem(newItem); // Menggunakan Provider untuk menambahkan item

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()), // Navigasi ke halaman Keranjang
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PrimaryColor, // Warna tombol dari constants.dart
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: SecondaryColor, width: 2), // Warna border dari constants.dart
                    ),
                  ),
                  child: Text(
                    'Masukkan Keranjang',
                    style: TextStyle(color: Colors.white, fontSize: 18),
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
