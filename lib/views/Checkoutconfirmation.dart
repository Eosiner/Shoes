import 'package:flutter/material.dart';
import 'package:shoes/views/Home.dart';
import 'package:shoes/views/keranjang_fill.dart';

class Checkoutconfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Sukses'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/keranjang.jpg',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 24),
            const Text(
              'Transaksi Anda Berhasil',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Segera anda akan segera kami\nlakukan proses pengiriman',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF275A65),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15), // Reduced padding
              ),
              child: const Text(
                'Order Sepatu Lainnya',
                style: TextStyle(color: Colors.white), // Ubah warna teks menjadi putih
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => keranjang_fill()));
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey, // Ubah warna tombol menjadi abu-abu
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15), // Reduced padding
              ),
              child: const Text('Lihat Orderan Saya'),
            ),
          ],
        ),
      ),
    );
  }
}
