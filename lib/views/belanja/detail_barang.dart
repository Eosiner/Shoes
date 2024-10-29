import 'package:flutter/material.dart';
import 'package:shoes/components/popup_add_chart.dart';

import '../Home.dart';


// void main()
// {
//    runApp(MyApp());
// }

//  class MyApp extends StatelessWidget {
//    @override
//    Widget build(BuildContext context) {
//      return MaterialApp(
//        home: Detail_barang(),
//      );

//    } }

class Detail_barang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            // Product Image
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset(
                'assets/adidasjuramo.jpg', // Pastikan gambar berada di folder 'assets'
                height: 250,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 16),

            // Product Information
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade100,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title
                    const Text(
                      "Adidas Jurdmo Speed",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    // Category and Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Running",
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Rp 1.800.000",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Description
                    const Text(
                      "Step into the timeless run. Crafted with smooth leather, they offer a sleek, premium finish while the rubber shell toe adds durability and iconic style. The signature 3-Stripes and bold Trefoil logo ensure a classic adidas feel.",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    // Spacer to push the button to the bottom
                    const Spacer(),

                    // Favorite button and Add to cart with padding at the bottom
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 18.0), // Menambahkan padding di bagian bawah
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {
                              // Add to favorite functionality
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SuccessDialog();
                                },
                              );
                            },
                            child: Text("Masukkan ke Keranjang"),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 24,
                              ),
                              textStyle: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
