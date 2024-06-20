import 'package:flutter/material.dart'; // Import Flutter Material library untuk komponen UI
import 'package:shared_preferences/shared_preferences.dart'; // Import package untuk mengelola data di SharedPreferences
import 'package:aplikasirental_ps/constants.dart'; // Import file constants.dart yang berisi konstanta seperti PrimaryColor, SecondaryColor, dll.
import 'package:aplikasirental_ps/screens/profil/profilpengguna.dart'; // Import file UserProfileScreen untuk navigasi ke halaman profil pengguna

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey untuk mengakses form state
  final _nameController = TextEditingController(); // Controller untuk input nama
  final _usnController = TextEditingController(); // Controller untuk input username

  @override
  void initState() {
    super.initState();
    _loadProfileData(); // Memanggil fungsi _loadProfileData saat initState
  }

  void _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance(); // Mendapatkan instance dari SharedPreferences
    String nama = prefs.getString('nama') ?? ''; // Mendapatkan nama dari SharedPreferences, defaultnya kosong jika tidak ada
    String username = prefs.getString('username') ?? ''; // Mendapatkan username dari SharedPreferences, defaultnya kosong jika tidak ada

    setState(() {
      _nameController.text = nama; // Mengeset nilai controller nama sesuai data dari SharedPreferences
      _usnController.text = username; // Mengeset nilai controller username sesuai data dari SharedPreferences
    });
  }

  void _saveProfileChanges() async {
    if (_formKey.currentState!.validate()) { // Memvalidasi form jika valid
      String newName = _nameController.text.trim(); // Mendapatkan nilai baru nama dari controller, di-trim untuk menghapus spasi di awal dan akhir
      String newUsername = _usnController.text.trim(); // Mendapatkan nilai baru username dari controller, di-trim untuk menghapus spasi di awal dan akhir

      SharedPreferences prefs = await SharedPreferences.getInstance(); // Mendapatkan instance dari SharedPreferences
      await prefs.setString('nama', newName); // Menyimpan nilai baru nama ke SharedPreferences
      await prefs.setString('username', newUsername); // Menyimpan nilai baru username ke SharedPreferences

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfileScreen(updatedName: newName, updatedUsn: newUsername,), // Navigasi ke UserProfileScreen dengan menyertakan nilai baru nama dan username
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: TextStyle(color: Colors.white)), // Judul AppBar
        backgroundColor: PrimaryColor, // Warna latar belakang AppBar
        leading: IconButton( // IconButton di sebelah kiri AppBar
          icon: Icon(Icons.arrow_back, color: Colors.white), // Icon panah kembali dengan warna putih
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfileScreen(updatedName: 'nama', updatedUsn: 'username',), // Navigasi kembali ke UserProfileScreen dengan nama dan username default
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView( // SingleChildScrollView agar konten dapat di-scroll
        padding: EdgeInsets.all(16.0), // Padding pada konten
        child: Form( // Form untuk mengelola inputan
          key: _formKey, // Menggunakan GlobalKey untuk mengakses state form
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField( // Input field untuk nama
                controller: _nameController, // Menggunakan controller untuk mengelola nilai input
                decoration: InputDecoration(labelText: 'Nama'), // Label input
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong masukkan nama'; // Validasi jika input kosong
                  }
                  return null;
                },
              ),
              SizedBox(height: 16), // Spacer vertical antara input fields
              TextFormField( // Input field untuk username
                controller: _usnController, // Menggunakan controller untuk mengelola nilai input
                decoration: InputDecoration(labelText: 'Username'), // Label input
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong masukkan username'; // Validasi jika input kosong
                  }
                  if (!RegExp(r'^[a-zA-Z0-9_]{5,}$').hasMatch(value)) {
                    return 'Masukkan username yang valid'; // Validasi untuk format username
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Spacer vertical sebelum tombol Simpan Perubahan
              ElevatedButton( // Tombol untuk menyimpan perubahan
                onPressed: _saveProfileChanges, // Fungsi yang dipanggil saat tombol ditekan
                child: Text('Simpan Perubahan', style: TextStyle(color: Colors.white)), // Label tombol
                style: ElevatedButton.styleFrom( // Styling untuk tombol
                  backgroundColor: PrimaryColor, // Warna latar belakang tombol
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Padding tombol
                  shape: RoundedRectangleBorder( // Bentuk tombol
                    borderRadius: BorderRadius.circular(10), // BorderRadius untuk sudut melengkung
                    side: BorderSide(color: SecondaryColor, width: 2), // BorderSide untuk border
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose(); // Membersihkan controller nama saat widget di-dispose
    _usnController.dispose(); // Membersihkan controller username saat widget di-dispose
    super.dispose(); // Memanggil dispose dari superclass
  }
}
