import 'package:flutter/material.dart'; // Package untuk pengembangan UI dengan Flutter
import 'package:cloud_firestore/cloud_firestore.dart'; // Package untuk berinteraksi dengan Firestore
import 'package:intl/intl.dart'; // Package untuk formatting tanggal
import 'package:aplikasirental_ps/constants.dart'; // File dengan konstanta aplikasi
import 'package:aplikasirental_ps/screens/keranjang/keranjang.dart'; // Halaman keranjang
import 'package:aplikasirental_ps/screens/booking/qrcodepage.dart'; // Halaman QR Code

class BookingScreen extends StatefulWidget {
  final List<Item> items;
  final double totalPrice;

  BookingScreen({required this.items, required this.totalPrice});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // Controller untuk input nama
  final TextEditingController _namaController = TextEditingController();

  // Variabel untuk menyimpan tanggal dan waktu yang dipilih
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  // Status pembayaran, default 'paid'
  String _status = "paid";

  // Method untuk menambahkan pemesanan
  void _addBooking() async {
    // Generate nomor invoice
    final String invoice = _generateInvoice();

    // Ambil data dari input dan widget
    final String nama = _namaController.text;
    final List<String> barang = widget.items.map((item) => item.title).toList();
    final String tanggal = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    final String waktu = _selectedTime!.format(context);
    final List<int> durasi = widget.items.map((item) => item.durasi).toList();
    final int tarif = widget.totalPrice.toInt();

    // Simpan data pemesanan ke Firestore
    await FirebaseFirestore.instance.collection('transaksi').add({
      'invoice': invoice,
      'nama': nama,
      'barang': barang,
      'tanggal': tanggal,
      'waktu': waktu,
      'durasi': durasi,
      'tarif': tarif,
      'status': _status, // Set status 'paid'
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Tambahkan notifikasi pemesanan sukses ke Firestore
    await FirebaseFirestore.instance.collection('notifikasi').add({
      'judul': 'Peminjaman Sukses',
      'pesan': 'Peminjaman untuk $nama dengan invoice $invoice berhasil!',
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Clear input nama dan reset tanggal, waktu, dan status
    _namaController.clear();
    setState(() {
      _selectedDate = null;
      _selectedTime = null;
      _status = "paid";
    });

    // Tampilkan snackbar untuk memberi konfirmasi pemesanan berhasil
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Peminjaman untuk $nama berhasil!')),
    );

    // Navigasi ke halaman QRCodePage dengan parameter yang sesuai
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRCodePage(
          invoice: invoice,
          nama: nama,
          totalPrice: widget.totalPrice,
        ),
      ),
    );
  }

  // Method untuk menghasilkan nomor invoice
  String _generateInvoice() {
    final now = DateTime.now();
    return 'INV-${now.year}${now.month}${now.day}-${now.microsecondsSinceEpoch}';
  }

  // Method untuk memilih tanggal
  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  // Method untuk memilih waktu
  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        _selectedTime = selectedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: TextStyle(color: Colors.white)),
        backgroundColor: PrimaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigasi ke halaman CartScreen saat tombol kembali ditekan
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input field untuk nama
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            SizedBox(height: 10),

            // Judul daftar barang yang dipesan
            Text(
              'Barang:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Daftar barang yang dipesan
            Expanded(
              child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  return ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.versi),
                    trailing: Text('Rp ${item.price}'),
                  );
                },
              ),
            ),
            SizedBox(height: 10),

            // Pilihan untuk memilih tanggal dan waktu
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Menampilkan dialog untuk memilih tanggal
                    FocusScope.of(context).requestFocus(FocusNode());
                    _selectDate(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BackgroundColor,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: SecondaryColor, width: 2),
                    ),
                  ),
                  child: Text(
                    _selectedDate != null
                        ? 'Tanggal: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'
                        : 'Pilih Tanggal',
                    style: TextStyle(color: PriceTextColor),
                  ),
                ),
                SizedBox(width: 36,),

                ElevatedButton(
                  onPressed: () {
                    // Menampilkan dialog untuk memilih waktu
                    FocusScope.of(context).requestFocus(FocusNode());
                    _selectTime(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BackgroundColor,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: SecondaryColor, width: 2),
                    ),
                  ),
                  child: Text(
                    _selectedTime != null
                        ? 'Waktu: ${_selectedTime!.format(context)}'
                        : 'Pilih Waktu',
                    style: TextStyle(color: PriceTextColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Informasi durasi peminjaman
            Text(
              'Durasi : ${widget.items.fold(0, (sum, item) => sum + item.durasi)} Hari',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Total tarif pemesanan
            Text(
              'Total Tarif: Rp ${widget.totalPrice.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Tombol untuk menyelesaikan pemesanan
            ElevatedButton(
              onPressed: _addBooking,
              style: ElevatedButton.styleFrom(
                backgroundColor: PrimaryColor,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: SecondaryColor, width: 2),
                ),
              ),
              child: Text(
                'Bayar Sekarang',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
