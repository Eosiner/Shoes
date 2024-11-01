import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes/views/belanja/keranjang_fill.dart';
import 'package:shoes/views/setting/profile.dart';
import 'package:shoes/views/qr/scanqr.dart';
import 'belanja/detail_barang.dart';

import 'messages/chatscreen.dart';

// void main() {
//   runApp(const Home());
// }

class Home extends StatefulWidget {
  const Home({super.key});

  Future<String?> getUSerID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userID'); // Mengambil userID dari SharedPreferences
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  // Fungsi untuk menangani pergantian halaman
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: widget.getUSerID(), // Ambil userID dari SharedPreferences
      builder: (context, snapshot) {
        // Jika masih menunggu data
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Jika ada error atau userID tidak ditemukan
        if (!snapshot.hasData || snapshot.hasError) {
          return const Center(child: Text("User ID not found"));
        }

        String? userID = snapshot.data; // Ambil userID dari snapshot

        // Buat halaman berdasarkan userID yang telah diambil
        final List<Widget> _pages = [
          ShoeStoreHome(),
          ChatScreen(),
          const scanqr(),
          const keranjang_fill(),
          Profile(userID: userID ?? ''), // Berikan userID ke halaman Profile
        ];

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.white,
            body: IndexedStack(
              index: _selectedIndex,
              children: _pages, // Gunakan halaman dengan userID yang valid
            ),
            bottomNavigationBar: _selectedIndex != 2 // Jika bukan ScanQR
                ? BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: _selectedIndex, // Menunjukkan item aktif
                    onTap: _onItemTapped, // Menangani pergantian halaman
                    items: const [
                      BottomNavigationBarItem(
                          // icon: ImageIcon(AssetImage('assets/home.jpg')),
                          icon: Icon(Icons.home),
                          label: ''),
                      BottomNavigationBarItem(
                          // icon: ImageIcon(AssetImage('assets/pesan.jpg')),
                          icon: Icon(Icons.message),
                          label: ''),
                      BottomNavigationBarItem(
                          // icon: ImageIcon(AssetImage('assets/qrcode.jpg')),
                          icon: Icon(Icons.qr_code),
                          label: ''),
                      BottomNavigationBarItem(
                          // icon: ImageIcon(AssetImage('assets/keranjang.jpg')),
                          icon: Icon(Icons.shopping_cart),
                          label: ''),
                      BottomNavigationBarItem(
                          // icon: ImageIcon(AssetImage('assets/person.jpg')),
                          icon: Icon(Icons.person),
                          label: ''),
                    ],
                  )
                : null, // Tidak menampilkan BottomNavigationBar jika ScanQR aktif
          ),
        );
      },
    );
  }
}

class ShoeStoreHome extends StatelessWidget {
  ShoeStoreHome({super.key});

  var userID; // Declare userID
  final List<String> categories = [
    'All Shoes',
    'Running',
    'Training',
    'Basketball',
    'Hiking'
  ];

  Future<String?> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('userID');
    return userID;
  }

  // Fungsi untuk mengambil data produk dari Firestore
  Future<List<Map<String, dynamic>>> getProductsFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<Map<String, dynamic>> products = [];
    try {
      QuerySnapshot shopsSnapshot = await firestore.collection('shops').get();

      if (shopsSnapshot.docs.isEmpty) {
        print("Tidak toko ditemukan!");
        return [];
      }

      for (var shopDoc in shopsSnapshot.docs) {
        String shopId = shopDoc.id;
        print("Mengambil produk dari toko $shopId");

        QuerySnapshot productsSnapshot = await firestore
            .collection('shops')
            .doc(shopId)
            .collection('products')
            .get();

        if (productsSnapshot.docs.isEmpty) {
          print("Tidak ada produk pada toko $shopId");
        }

        for (var doc in productsSnapshot.docs) {
          Map<String, dynamic> productData = doc.data() as Map<String, dynamic>;
          productData['shopId'] = shopId;
          productData['productId'] = doc.id;
          products.add(productData);
        }
      }
    } catch (e) {
      print("Error loading products: $e");
    }
    // print(products);
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder(
          future: getUserID(), // Get userID before building
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Error loading user data"));
            }

            var userName;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(userID)
                        .get(),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (userSnapshot.hasError || !userSnapshot.hasData) {
                        return const Text("Error loading user data");
                      }

                      var userData = userSnapshot.data!;
                      userName = userData['name'];
                      // print(userName);
                      // print("User id: ${userID}");
                      // print("data: ${userData},");
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hallo, ${userData['name'] ?? 'Ucup'}', // Using userData['name'] for personalization
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '@${userData['name'] ?? 'ucup'}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: userData['photoURL'] != null
                                ? NetworkImage(userData['photoURL'])
                                : const AssetImage(
                                    'assets/default_profile.jpeg'),
                          ),
                        ],
                      );
                    },
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
                          backgroundColor:
                              index == 0 ? Colors.blue : Colors.grey[200],
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
                        child: GestureDetector(
                          // onTap: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Detail_barang()),
                          //   );
                          // },
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
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(8)),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/adidasjuramo.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hiking',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Text(
                                        'Adidas Juramo Speed',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Rp 1.589.000',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                        'For You',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: getProductsFromFirestore(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text("Error loading products"));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("No products found"));
                      }

                      List<Map<String, dynamic>> products = snapshot.data!;

                      return ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ListTile(
                            leading: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: product['images'] != null &&
                                      product['images'].isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        product['images'][
                                            0], // Ambil gambar pertama dari list URL
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Icon(Icons.image_not_supported),
                            ),
                            title: Text(
                              product['type'] ?? 'No Category',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['name'] ?? 'No Name',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  (product['price'] != null
                                      ? "Rp ${product['price'].toString()}"
                                      : 'No Price'),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Detail_barang(productId: product['productId'], shopId: product['shopId'],)),
                            );
                          },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ScanQR extends StatelessWidget {
  // Pastikan menggunakan huruf kapital
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
                const Text('QR',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                  child:
                      Image.asset('assets/galery.jpg', width: 24, height: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
