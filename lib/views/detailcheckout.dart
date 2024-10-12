import 'package:flutter/material.dart';
import 'package:shoes/views/Checkoutconfirmation.dart';
import 'package:shoes/views/alamat.dart';

class detailcheckout extends StatelessWidget {
  const detailcheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Detail Checkout'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('List Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildItemCard(),
            const SizedBox(height: 16),
            _buildAddressCard(context),
            const SizedBox(height: 16),
            _buildOrderSummaryCard(),
            const SizedBox(height: 16),
            _buildVoucherCard(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Checkoutconfirmation()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF275A65),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text(
            'Checkout Sekarang',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildItemCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Image.asset('assets/adidasjuramo.jpg', width: 80, height: 80),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Adidas Juramo Speed', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Rp 15.699.000', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const Text('1 items'),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.store, size: 24),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lokasi Toko', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Shoes Store'),
                ],
              ),
            ),
            const Icon(Icons.location_on, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const alamat()));
                },
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Alamat Anda', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Rumah Ucup'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Cek Ringkasan Belanja Kamu', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildSummaryRow('Total Harga', 'Rp 15.699.000'),
            _buildSummaryRow('Banyak Barang', '1'),
            _buildSummaryRow('Total Ongkos Kirim', 'Free'),
            _buildSummaryRow('Biaya Jasa Aplikasi', 'Free'),
            const Divider(),
            _buildSummaryRow('Total', 'Rp 15.699.000', isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildVoucherCard(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text('Ada Voucher buat kamu nih!'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Contoh: Buka halaman pilihan voucher
        },
      ),
    );
  }
}
