import 'package:flutter/material.dart';

class VoucherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voucher Saya', style: TextStyle(fontSize: 20)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Aksi kembali ke halaman sebelumnya
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Masukkan Kode Voucher',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                voucherItem('Gratis Ongkir', 'Min. Rp 100', 'Berlaku hingga 31 Des 2024'),
                voucherItem('Diskon 5% s/d Rp40RB', 'Min. Rp 50.000', 'Berlaku hingga 31 Des 2024'),
                voucherItem('Diskon 10% s/d Rp100RB', 'Min. Rp 100.000', 'Berlaku hingga 31 Des 2024'),
                voucherItem('Diskon 15% s/d Rp150RB', 'Min. Rp 150.000', 'Berlaku hingga 31 Des 2024'),
                voucherItem('Cashback 3% s/d 300rb', 'Min. Rp 150.000', 'Berlaku hingga 31 Des 2024'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Aksi tombol forward
              },
              child: Icon(Icons.arrow_forward),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff1F41BB),
                shape: CircleBorder(),
                padding: EdgeInsets.all(24),
                iconColor: Colors.white
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget voucherItem(String title, String minSpend, String validity) {
    return Card(
      shape: Border.all(),
      color: Color(0xff3B7D8B),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 18)),
        subtitle: Text('$minSpend\n$validity', style: TextStyle(color: Colors.black)),
        trailing: ElevatedButton(
          onPressed: () {
            // Aksi tombol 'Gunakan'
          },
          child: Text('Gunakan'),
        ),
      ),
    );
  }
}
