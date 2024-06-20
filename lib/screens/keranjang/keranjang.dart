import 'package:aplikasirental_ps/constants.dart';  // Import file konstanta aplikasi
import 'package:aplikasirental_ps/screens/booking/bookingpage.dart';  // Import halaman BookingScreen untuk navigasi ke halaman pemesanan
import 'package:flutter/material.dart';  // Import framework Flutter untuk membangun UI
import 'package:provider/provider.dart';  // Import package provider untuk manajemen state

class Item {
  final String imagePath;  // Path gambar untuk item
  final String title;  // Judul item
  final String versi;  // Versi atau keterangan tambahan item
  final int price;  // Harga item
  final int durasi;  // Durasi atau waktu peminjaman untuk item

  // Constructor untuk inisialisasi semua properti wajib
  Item({
    required this.imagePath,
    required this.title,
    required this.versi,
    required this.price,
    required this.durasi,
  });
}

class CartProvider with ChangeNotifier {
  List<Item> _items = [];  // List untuk menyimpan semua item dalam keranjang
  double _totalPrice = 0.0;  // Total harga dari semua item dalam keranjang

  List<Item> get items => _items;  // Getter untuk mendapatkan semua item dalam keranjang
  double get totalPrice => _totalPrice;  // Getter untuk mendapatkan total harga

  // Menambahkan item ke keranjang
  void addItem(Item item) {
    _items.add(item);
    _totalPrice += item.price;
    notifyListeners();  // Memberitahu listener bahwa state berubah
  }

  // Menghapus item dari keranjang
  void removeItem(Item item) {
    _totalPrice -= item.price;
    _items.remove(item);
    notifyListeners();  // Memberitahu listener bahwa state berubah
  }

  // Mengosongkan keranjang
  void clearCart() {
    _items = [];
    _totalPrice = 0.0;
    notifyListeners();  // Memberitahu listener bahwa state berubah
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang', style: TextStyle(color: Colors.white)),
        backgroundColor: PrimaryColor,  // Menggunakan warna utama dari file konstanta
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(item.imagePath,
                                  width: 50, height: 50),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 4),
                                    Text(item.versi,
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ),
                              Text('Rp ${item.price}',
                                  style: TextStyle(
                                      color: PriceTextColor, fontSize: 16)),
                              IconButton(
                                icon: Icon(Icons.remove_shopping_cart),
                                onPressed: () {
                                  cart.removeItem(item);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rp ${cart.totalPrice.toStringAsFixed(0)}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingScreen(
                          items:
                              Provider.of<CartProvider>(context, listen: false)
                                  .items,
                          totalPrice:
                              Provider.of<CartProvider>(context, listen: false)
                                  .totalPrice,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PrimaryColor,  // Menggunakan warna utama dari file konstanta
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: SecondaryColor, width: 2),  // Menggunakan warna sekunder dari file konstanta
                    ),
                  ),
                  child: Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
