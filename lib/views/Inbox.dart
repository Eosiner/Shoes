import 'package:flutter/material.dart';
import 'scanqr.dart'; // Import halaman ScanQR
import 'keranjang_fill.dart'; // Import halaman Keranjang
import 'detail_barang.dart'; // Import halaman DetailBarang
import 'home.dart'; // Import halaman Home

class Inbox extends StatefulWidget {
  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Image.asset('assets/shoeslogo.jpg'),
        title: const Center( // Pindahkan ke Center untuk menengahkan teks
          child: Text('Inbox QR', style: TextStyle(color: Colors.black)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context); // Navigasi kembali
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView(
                children: const [
                  TransactionItem(text: 'Pembayaran ....'),
                  TransactionItem(text: 'Pembayaran ....'),
                  TransactionItem(text: 'Pembayaran ....'),
                  TransactionItem(text: 'Pembayaran 1.000.000'), // Contoh item tambahan
                  TransactionItem(text: 'Pembayaran 500.000'),   // Contoh item tambahan
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final String text;

  const TransactionItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
