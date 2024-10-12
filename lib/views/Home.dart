import 'package:flutter/material.dart';
import 'package:shoes/views/keranjang_fill.dart';
import 'package:shoes/views/scanqr.dart';
import 'detail_barang.dart';
import 'package:shoes/views/pesan.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  // Daftar halaman untuk setiap item di BottomNavigationBar
  final List<Widget> _pages = [
    ShoeStoreHome(),  // Halaman utama toko sepatu
    pesan(), // Halaman placeholder (ganti sesuai kebutuhan)
    const scanqr(),      // Pastikan menggunakan nama kelas dengan huruf kapital
    const keranjang_fill(), // Pastikan menggunakan nama kelas dengan huruf kapital
    const Placeholder(),
  ];

  // Fungsi untuk menangani pergantian halaman
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        // Hanya tampilkan BottomNavigationBar jika halaman bukan ScanQR
        bottomNavigationBar: _selectedIndex != 2 // Misal indeks halaman ScanQR adalah 2
            ? BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex, // Menunjukkan item yang aktif
          onTap: _onItemTapped, // Menangani perubahan halaman
          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/home.jpg')), label: ''),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/pesan.jpg')), label: ''),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/qrcode.jpg')), label: ''),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/keranjang.jpg')), label: ''),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/person.jpg')), label: ''),
          ],
        )
            : null, // Tidak menampilkan BottomNavigationBar jika halaman ScanQR aktif
      ),
    );
  }
}

class ShoeStoreHome extends StatelessWidget {
  final List<String> categories = [
    'All Shoes', 'Running', 'Training', 'Basketball', 'Hiking'
  ];

  final List<Map<String, String>> forUcupProducts = [
    {
      'name': 'Air Jordan Luka 2',
      'category': 'Basketball',
      'price': 'Rp 2.199.000',
      'image': 'assets/airjordanluka2.jpg',
    },
    {
      'name': 'Adidas Response Runner',
      'category': 'Running',
      'price': 'Rp 850.000',
      'image': 'assets/response_runner.jpg',
    },
    {
      'name': 'Nike Zoom Fly',
      'category': 'Running',
      'price': 'Rp 1.500.000',
      'image': 'assets/nike_zoom_fly.jpg',
    },
    {
      'name': 'Puma Hybrid Astro',
      'category': 'Training',
      'price': 'Rp 1.299.000',
      'image': 'assets/puma_hybrid_astro.jpg',
    },
    {
      'name': 'Reebok Nano X2',
      'category': 'Training',
      'price': 'Rp 1.800.000',
      'image': 'assets/reebok_nano_x2.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hallo, Ucup',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '@ucup',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/ppgojo.jpg'),
                    radius: 25,
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      backgroundColor: index == 0 ? Colors.blue : Colors.grey[200],
                      label: Text(
                        categories[index],
                        style: TextStyle(
                          color: index == 0 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    'Popular Products',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector( // Use GestureDetector to capture tap events
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Detail_barang()),
                        );
                      },
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                                  image: const DecorationImage(
                                    image: AssetImage('assets/adidasjuramo.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hiking',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    'Adidas Juramo Speed',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Rp 1.589.000',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    'For Ucup',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: forUcupProducts.length,
                itemBuilder: (context, index) {
                  final product = forUcupProducts[index];
                  return ListTile(
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage(product['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      product['category']!,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name']!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text(
                          product['price']!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScanQR extends StatelessWidget { // Pastikan menggunakan huruf kapital
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                const Text('QR', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(), // Menjaga jarak di kanan agar QR tetap di tengah
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/qrcode.jpg', width: 200, height: 200),
                  const SizedBox(height: 16),
                  const Text('QR ready', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    print("Flash icon tapped");
                    // Tambahkan logika untuk fitur flash
                  },
                  child: Image.asset('assets/flash.jpg', width: 24, height: 24),
                ),
                GestureDetector(
                  onTap: () {
                    print("Inbox icon tapped");
                    // Tambahkan logika untuk fitur inbox
                  },
                  child: Image.asset('assets/inbox.jpg', width: 24, height: 24),
                ),
                GestureDetector(
                  onTap: () {
                    print("Gallery icon tapped");
                    // Tambahkan logika untuk fitur galeri
                  },
                  child: Image.asset('assets/galery.jpg', width: 24, height: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
