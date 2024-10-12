import 'package:flutter/material.dart';
import 'package:shoes/views/detailcheckout.dart';

class keranjang_fill extends StatelessWidget {
  const keranjang_fill({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Anda'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Column(
        children: [
          // Cart item
          const CartItemWidget(
            productName: 'Adidas Juramo Speed',
            productPrice: 1800000,
            productImage: 'assets/adidasjuramo.jpg',
            quantity: 1,
          ),
          const Spacer(),

          // Subtotal Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Rp 1.800.000',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Checkout Button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFF275A65), // Warna latar belakang tombol
                foregroundColor: Colors.white, // Warna teks menjadi putih
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const detailcheckout()), // Pastikan nama kelas sesuai
                );
              },
              child: const Text(
                'Lanjut Checkout',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemWidget extends StatefulWidget {
  final String productName;
  final int productPrice;
  final String productImage;
  final int quantity;

  const CartItemWidget({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.quantity,
  });

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    quantity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(10), // Mengurangi padding dalam kotak
        height: 139, // Menentukan tinggi kotak agar lebih rendah
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Product Image
            Image.asset(
              widget.productImage,
              width: 60, // Mengurangi lebar gambar
              height: 60, // Mengurangi tinggi gambar
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),

            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rp ${widget.productPrice}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            // Quantity Controls
            Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center align buttons
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                ),
                Text(
                  quantity.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (quantity > 1) quantity--;
                    });
                  },
                ),
              ],
            ),

            // Remove Button
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Tambahkan logika untuk menghapus item di sini
              },
            ),
          ],
        ),
      ),
    );
  }
}
