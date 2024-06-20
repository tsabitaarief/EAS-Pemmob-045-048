import 'package:aplikasirental_ps/screens/detail/detailrekom.dart'; // Mengimpor halaman detail rekomendasi
import 'package:aplikasirental_ps/screens/homepage/sidebar/navdrawer.dart'; // Mengimpor widget navdrawer
import 'package:flutter/material.dart'; // Mengimpor paket Flutter untuk membangun UI
import 'package:aplikasirental_ps/constants.dart'; // Mengimpor file constants.dart yang berisi konstanta-konstanta yang digunakan dalam aplikasi
import 'package:aplikasirental_ps/screens/homepage/choicecard/cdgame.dart'; // Mengimpor halaman CD Game
import 'package:aplikasirental_ps/screens/homepage/choicecard/controller.dart'; // Mengimpor halaman Controller
import 'package:aplikasirental_ps/screens/homepage/choicecard/playstation.dart'; // Mengimpor halaman Playstation
import 'package:aplikasirental_ps/screens/keranjang/keranjang.dart'; // Mengimpor halaman Keranjang
import 'package:aplikasirental_ps/landingpage/masuk.dart'; // Mengimpor halaman Login
import 'package:aplikasirental_ps/screens/notifikasi/notifikasi.dart'; // Mengimpor halaman Notifikasi
import 'package:aplikasirental_ps/screens/profil/profilpengguna.dart'; // Mengimpor halaman Profil Pengguna
import 'package:aplikasirental_ps/screens/riwayat/riwayat.dart'; // Mengimpor halaman Riwayat

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
      initialRoute: '/', // Mengatur rute awal ke halaman login
      routes: {
        '/': (context) => LoginPage(), // Menyediakan rute untuk halaman login
        '/homepage': (context) => MainScreen(userId: "user_id"), // Menyediakan rute untuk halaman utama
        '/keranjang': (context) => CartScreen(), // Menyediakan rute untuk halaman keranjang
        '/history': (context) => HistoryScreen(), // Menyediakan rute untuk halaman riwayat
        '/profilpengguna': (context) => UserProfileScreen(updatedName: 'nama', updatedUsn: 'username',), // Menyediakan rute untuk halaman profil pengguna
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  final String userId;

  const MainScreen({Key? key, required this.userId}) : super(key: key); // Konstruktor untuk MainScreen dengan parameter userId

  @override
  State<MainScreen> createState() => _MainScreenState(); // Membuat state untuk MainScreen
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0; // Inisialisasi indeks halaman awal

  List<Widget> pageList = [
    HomeScreen(), // Halaman Beranda
    CartScreen(), // Halaman Keranjang
    HistoryScreen(), // Halaman Riwayat
    UserProfileScreen(updatedName: '', updatedUsn: '',), // Halaman Profil Pengguna
  ];

  void onTabTapped(int index) {
    setState(() {
      pageIndex = index; // Mengubah indeks halaman saat tab di-tap
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[pageIndex], // Menampilkan halaman berdasarkan indeks halaman
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex, // Mengatur indeks halaman yang aktif
        onTap: onTabTapped, // Memanggil fungsi onTabTapped saat tab di-tap
        type: BottomNavigationBarType.shifting, // Mengatur tipe BottomNavigationBar menjadi shifting
        elevation: 0,
        iconSize: 30, // Mengatur ukuran ikon
        selectedIconTheme: IconThemeData(
          color: Colors.white, // Mengatur warna ikon yang dipilih
        ),
        selectedItemColor: Colors.white, // Mengatur warna item yang dipilih
        unselectedIconTheme: IconThemeData(
          color: Colors.white54, // Mengatur warna ikon yang tidak dipilih
        ),
        showUnselectedLabels: false, // Menyembunyikan label item yang tidak dipilih
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled), // Ikon untuk tab Beranda
            label: "Beranda",
            backgroundColor: PrimaryColor, // Warna latar belakang tab Beranda
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), // Ikon untuk tab Keranjang
            label: "Keranjang",
            backgroundColor: PrimaryColor, // Warna latar belakang tab Keranjang
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history), // Ikon untuk tab Riwayat
            label: "Riwayat",
            backgroundColor: PrimaryColor, // Warna latar belakang tab Riwayat
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Ikon untuk tab Profil
            label: "Profil",
            backgroundColor: PrimaryColor, // Warna latar belakang tab Profil
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(), // Menambahkan drawer untuk navigasi
      appBar: AppBar(
        backgroundColor: PrimaryColor, // Mengatur warna latar belakang AppBar
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white), // Ikon untuk tombol menu
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavDrawer()), // Navigasi ke widget NavDrawer
            );
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 4,
            ),
            Text('Welcome, Fajar Sadboy!',
                style: TextStyle(color: Colors.white)), // Menampilkan teks sambutan
            Text('Explore our latest offerings',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.white)), // Menampilkan teks deskripsi
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.notifications),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationsScreen()), // Navigasi ke halaman notifikasi
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Mengatur padding di sekitar konten
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16), // Memberi jarak vertikal 16px
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PSPage()), // Navigasi ke halaman PSPage
                      );
                    },
                    child: ChoiceCard(
                        icon: Icons.videogame_asset, label: 'PS Console'), // Menampilkan kartu pilihan untuk PS Console
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PSStickPage()), // Navigasi ke halaman PSStickPage
                      );
                    },
                    child: ChoiceCard(
                        icon: Icons.sports_esports, label: 'Controler'), // Menampilkan kartu pilihan untuk Controller
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PSGamePage()), // Navigasi ke halaman PSGamePage
                      );
                    },
                    child: ChoiceCard(icon: Icons.album, label: 'CD Game'), // Menampilkan kartu pilihan untuk CD Game
                  ),
                ],
              ),
              SizedBox(height: 16), // Memberi jarak vertikal 16px
              Text(
                'Rekomendasi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16), // Memberi jarak vertikal 16px
              GridView.builder(
                shrinkWrap: true, // Menjadikan grid view menyesuaikan dengan kontennya
                physics: NeverScrollableScrollPhysics(), // Menonaktifkan scroll pada grid view
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Jumlah kolom dalam grid
                  crossAxisSpacing: 16, // Jarak antar kolom
                  mainAxisSpacing: 16, // Jarak antar baris
                  childAspectRatio: 0.75, // Rasio aspek anak-anak grid
                ),
                itemCount: PSPage.psTypes.length, // Jumlah item dalam grid
                itemBuilder: (context, index) {
                  return Draggable(
                    feedback: RekomCard(
                      imagePath: PSPage.psTypes[index]['image']!,
                      title: PSPage.psTypes[index]['title']!,
                      subtitle: PSPage.psTypes[index]['subtitle']!,
                      price1: PSPage.psTypes[index]['price1']!,
                      price2: PSPage.psTypes[index]['price2']!,
                      price3: PSPage.psTypes[index]['price3']!,
                      duration1: PSPage.psTypes[index]['duration1'],
                      duration2: PSPage.psTypes[index]['duration2'],
                      duration3: PSPage.psTypes[index]['duration3'],
                    ),
                    childWhenDragging: Container(), // Menampilkan container kosong saat item di-drag
                    data: index, // Menyimpan data indeks item
                    child: RekomCard(
                      imagePath: PSPage.psTypes[index]['image']!,
                      title: PSPage.psTypes[index]['title']!,
                      subtitle: PSPage.psTypes[index]['subtitle']!,
                      price1: PSPage.psTypes[index]['price1']!,
                      price2: PSPage.psTypes[index]['price2']!,
                      price3: PSPage.psTypes[index]['price3']!,
                      duration1: PSPage.psTypes[index]['duration1'],
                      duration2: PSPage.psTypes[index]['duration2'],
                      duration3: PSPage.psTypes[index]['duration3'],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChoiceCard extends StatelessWidget {
  final IconData icon; // Ikon yang ditampilkan dalam kartu
  final String label; // Label yang ditampilkan dalam kartu

  ChoiceCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: PrimaryColor, // Warna latar belakang kartu
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Padding di sekitar konten kartu
        child: Column(
          children: [
            Container(
              height: 50,
              width: 50,
              child: Icon(
                icon,
                size: 30,
                color: Colors.white, // Warna ikon
              ),
            ),
            SizedBox(height: 8), // Memberi jarak vertikal 8px
            Text(label, style: TextStyle(fontSize: 16, color: Colors.white)), // Menampilkan label
          ],
        ),
      ),
    );
  }
}

class RekomCard extends StatelessWidget {
  final String imagePath; // Path gambar yang ditampilkan
  final String title; // Judul yang ditampilkan
  final String subtitle; // Subjudul yang ditampilkan
  final int price1; // Harga pertama yang ditampilkan
  final int price2; // Harga kedua yang ditampilkan
  final int price3; // Harga ketiga yang ditampilkan
  final int duration1; // Durasi pertama yang ditampilkan
  final int duration2; // Durasi kedua yang ditampilkan
  final int duration3; // Durasi ketiga yang ditampilkan

  const RekomCard({
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
              builder: (context) => DetailRekom(
                imagePath: imagePath,
                subtitle: subtitle,
                title: title,
                price1: price1,
                price2: price2,
                price3: price3,
                duration1: duration1,
                duration2: duration2,
                duration3: duration3,
              ), // Navigasi ke halaman DetailRekom
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Padding di sekitar konten kartu
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
                  fontWeight: FontWeight.bold,
                  color: PrimaryTextColor, // Warna teks judul
                ),
              ),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: SecondaryTextColor, // Warna teks subjudul
                ),
              ),
              Text(
                'Rp$price1 - Rp$price3',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
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
