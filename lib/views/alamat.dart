import 'package:flutter/material.dart';
import 'package:shoes/views/pinpointalamat.dart';

class alamat extends StatelessWidget {
  const alamat({super.key});

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
        title: const Text('Alamat'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pinpointalamat()),
                );
              },
              child: const AddressBubble(
                title: 'Alamat',
                content: Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Alamat Anda', style: TextStyle(color: Colors.grey)),
                        Text('Rumah Ucup'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const AddressBubble(
              title: 'Alamat Lengkap',
              content: TextField(
                decoration: InputDecoration(
                  hintText: 'Masukkan alamat lengkap',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const AddressBubble(
              title: 'Catatan untuk si kurir',
              content: TextField(
                decoration: InputDecoration(
                  hintText: 'Tambahkan catatan',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const AddressBubble(
              title: 'Nama Penerima',
              content: TextField(
                decoration: InputDecoration(
                  hintText: 'Masukkan nama penerima',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          child: const Text('Simpan'),
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }
}

class AddressBubble extends StatelessWidget {
  final String title;
  final Widget content;

  const AddressBubble({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }
}
