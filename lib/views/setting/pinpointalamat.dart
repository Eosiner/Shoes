import 'package:flutter/material.dart';

class pinpointalamat extends StatelessWidget {
  const pinpointalamat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Tentukan Pinpoint Lokasi'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/optikudara.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.close, size: 18),
                  SizedBox(width: 8),
                  Text('Gunakan lokasi saat ini'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Simpan'),
              onPressed: () {
                // Handle save action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}