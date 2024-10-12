import 'package:flutter/material.dart';
import 'package:shoes/views/Home.dart';
import 'package:shoes/views/Inbox.dart'; // Import the inbox view

class scanqr extends StatelessWidget {
  const scanqr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    // Logo di pojok kiri
                    Image.asset('assets/shoeslogo.jpg', height: 40),
                    const SizedBox(width: 8),
                    // Spacer untuk memberi ruang antara logo dan teks
                    const Expanded(
                      child: Center(
                        child: Text(
                          'QR',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    // Tombol kembali di pojok kanan
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                        ); // Navigasi kembali ke halaman sebelumnya
                      },
                    ),
                  ],
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
                    // Add logic for flash feature
                  },
                  child: Image.asset('assets/flash.jpg', width: 24, height: 24),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Inbox()), // Navigate to Inbox
                    );
                  },
                  child: Image.asset('assets/inbox.jpg', width: 24, height: 24),
                ),
                GestureDetector(
                  onTap: () {
                    print("Gallery icon tapped");
                    // Add logic for gallery feature
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
