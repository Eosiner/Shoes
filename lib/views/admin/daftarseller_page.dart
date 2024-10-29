import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:shoes/service/firebase_Service.dart';

class DaftarSellerPage extends StatefulWidget {
  final String userID; // ID pengguna yang akan dijadikan ID dokumen di koleksi "shops"
  const DaftarSellerPage({super.key, required this.userID});

  @override
  _DaftarSellerPageState createState() => _DaftarSellerPageState();
}

class _DaftarSellerPageState extends State<DaftarSellerPage> {
  final _formKey = GlobalKey<FormState>();
  final _shopNameController = TextEditingController();
  final _shopAddressController = TextEditingController();
  // final FirebaseService _firebaseService = FirebaseService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  Future<void> registerSeller(
      String userID, String shopName, String shopAddress) async {
    // Menambahkan toko
    await _firestore.collection('shops').doc(userID).set({
      'shopName': shopName,
      'shopAddress': shopAddress,
      'createdAt': Timestamp.now(),
    });

    // Merubah role user
    await _firestore.collection('users').doc(userID).update({
      'role': 'seller',
    });
  }

  Future<void> _registerSeller() async {
    if (_formKey.currentState!.validate()) {
      String shopName = _shopNameController.text.trim();
      String shopAddress = _shopAddressController.text.trim();

      // Simpan data toko dan ubah role menjadi seller
      await registerSeller(widget.userID, shopName, shopAddress);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pendaftaran sebagai seller berhasil!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar sebagai Seller"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _shopNameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Toko',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nama toko';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _shopAddressController,
                decoration: const InputDecoration(
                  labelText: 'Alamat Toko',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan alamat toko';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: _registerSeller,
                  child: const Text('Daftar sebagai Seller'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
