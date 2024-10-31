import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:shoes/components/popup_add_chart.dart';
import '../Home.dart';

class Detail_barang extends StatefulWidget {
  final String productId;
  final String shopId;

  const Detail_barang({Key? key, required this.productId, required this.shopId})
      : super(key: key);

  @override
  _Detail_barangState createState() => _Detail_barangState();
}

class _Detail_barangState extends State<Detail_barang> {
  late PageController _pageController;
  late Future<Map<String, dynamic>?> _productFuture;
  int _currentPage = 0;
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _productFuture = getProductById(widget.shopId, widget.productId);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>?> getProductById(
      String shopId, String productId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      DocumentSnapshot productSnapshot = await firestore
          .collection('shops')
          .doc(shopId)
          .collection('products')
          .doc(productId)
          .get();

      if (productSnapshot.exists) {
        Map<String, dynamic> productData =
            productSnapshot.data() as Map<String, dynamic>;
        productData['productId'] = productId;
        return productData;
      } else {
        print("Product not found");
        return null;
      }
    } catch (e) {
      print("Error fetching product: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: FutureBuilder<Map<String, dynamic>?>(
          future: _productFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Error loading product details"));
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text("Product not found"));
            }

            var productData = snapshot.data!;
            List<String> media = (productData['images'] as List<dynamic>?)
                    ?.whereType<String>()
                    .toList() ??
                [];

            String? videoUrl = productData['video'];

            if (videoUrl != null && _videoController == null) {
              _videoController = VideoPlayerController.network(videoUrl)
                ..initialize().then((_) {
                  setState(() {});
                  _videoController?.setLooping(true);
                  _videoController?.play();
                });
            }

            return Column(
              children: [
                // Media Carousel
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 250,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: videoUrl != null
                              ? media.length + 1
                              : media.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                              if (_videoController != null) {
                                if (_currentPage == 0) {
                                  _videoController?.play();
                                } else {
                                  _videoController?.pause();
                                }
                              }
                            });
                          },
                          itemBuilder: (context, index) {
                            if (videoUrl != null &&
                                index == 0 &&
                                _videoController?.value.isInitialized == true) {
                              return AspectRatio(
                                aspectRatio:
                                    _videoController!.value.aspectRatio,
                                child: VideoPlayer(_videoController!),
                              );
                            }
                            int mediaIndex = videoUrl != null ? index - 1 : index;
                            return media.isNotEmpty &&
                                    mediaIndex >= 0 &&
                                    mediaIndex < media.length
                                ? Image.network(
                                    media[mediaIndex],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(Icons.broken_image,
                                            size: 60, color: Colors.red),
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Icon(Icons.image_not_supported,
                                        size: 60, color: Colors.grey),
                                  );
                          },
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_left, size: 40),
                          onPressed: () {
                            if (_currentPage > 0) {
                              _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            }
                          },
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_right, size: 40),
                          onPressed: () {
                            if (_currentPage <
                                (videoUrl != null
                                    ? media.length
                                    : media.length - 1)) {
                              _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                                  print(_currentPage);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Product Information Container
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade100,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          productData['name'] ?? "No Name",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              productData['type'] ?? "No Category",
                              style: const TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                productData['price'] != null
                                    ? "Rp ${productData['price']}"
                                    : "No Price",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          productData['description'] ?? "No Description Available",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.favorite_border),
                                onPressed: () {
                                  // Implement add to favorite functionality
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
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 24,
                                  ),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                child: const Text("Masukkan ke Keranjang"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}