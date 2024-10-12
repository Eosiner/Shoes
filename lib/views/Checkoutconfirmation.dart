import 'package:flutter/material.dart';

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
                // Handle order more shoes action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF275A65),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Order Sepatu Lainnya'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Handle view orders action
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[600],
              ),
              child: const Text('Lihat Orderan Saya'),
            ),
          ],
        ),
      ),
    );
  }
}