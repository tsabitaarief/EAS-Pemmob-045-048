import 'package:aplikasirental_ps/constants.dart'; // Mengimpor file constants.dart yang berisi konstanta-konstanta yang digunakan dalam aplikasi
import 'package:aplikasirental_ps/firebase_options.dart'; // Mengimpor file firebase_options.dart yang berisi konfigurasi Firebase
import 'package:aplikasirental_ps/screens/keranjang/keranjang.dart'; // Mengimpor file keranjang.dart yang berisi tampilan keranjang belanja
import 'package:flutter/material.dart'; // Mengimpor paket Flutter untuk membangun UI
import 'package:flutter/services.dart'; // Mengimpor paket Flutter untuk mengatur orientasi perangkat
import 'package:provider/provider.dart'; // Mengimpor paket Provider untuk state management
import 'package:firebase_core/firebase_core.dart'; // Mengimpor paket Firebase Core untuk inisialisasi Firebase
import 'landingpage/welcomescreen.dart'; // Mengimpor file welcomescreen.dart yang berisi tampilan layar sambutan

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Memastikan binding Widgets sudah diinisialisasi sebelum menjalankan aplikasi
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, // Menginisialisasi Firebase dengan opsi yang sesuai dengan platform saat ini
    );
  } catch (e) {
    print('Error initializing Firebase: $e'); // Menangkap dan mencetak kesalahan jika inisialisasi Firebase gagal                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
  }

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp, // Mengatur orientasi layar menjadi portrait ke atas
      DeviceOrientation.portraitDown, // Mengatur orientasi layar menjadi portrait ke bawah
    ],
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()), // Mengatur provider untuk state management keranjang belanja
      ],
      child: MyApp(), // Menjalankan aplikasi dengan widget MyApp sebagai root
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menonaktifkan banner debug
      title: 'AliBlue PS', // Menetapkan judul aplikasi
      theme: ThemeData(
        fontFamily: 'Poppins', // Mengatur font default aplikasi
        scaffoldBackgroundColor: BackgroundColor, // Mengatur warna latar belakang scaffold
        primaryColor: PrimaryColor, // Mengatur warna utama aplikasi
        textTheme: Theme.of(context).textTheme.apply(bodyColor: PrimaryTextColor), // Mengatur tema teks dengan warna teks utama
        visualDensity: VisualDensity.adaptivePlatformDensity, // Mengatur densitas visual sesuai dengan platform
      ),
      home: WelcomeScreen(), // Menetapkan WelcomeScreen sebagai layar utama aplikasi
    );
  }
}
