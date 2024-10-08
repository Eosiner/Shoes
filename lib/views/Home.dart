import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShoeStoreHome(),
    );
  }
}

class ShoeStoreHome extends StatelessWidget {
  final List<String> categories = ['All Shoes', 'Running', 'Training', 'Basketball', 'Hiking'];

  // Menambahkan daftar produk untuk "For Ucup"
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
                                  image: AssetImage('assets/adidasjuramo.jpg'), // Gambar Adidas Juramo
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
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text(
                          product['price']!,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/home.jpg')), label: ''),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/pesan.jpg')), label: ''),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/qrcode.jpg')), label: ''),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/keranjang.jpg')), label: ''),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/person.jpg')), label: ''),
        ],
      ),
    );
  }
}
