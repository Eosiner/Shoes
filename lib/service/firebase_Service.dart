import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class FirebaseService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> uploadImages(
      List<File> images, String userId, String productId) async {
    List<String> imageUrls = [];
    for (var image in images) {
      String filePath =
          'products/$userId/$productId/images/${DateTime.now().millisecondsSinceEpoch}.jpg';
      TaskSnapshot snapshot = await _storage.ref(filePath).putFile(image);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }
    return imageUrls;
  }

  Future<String> uploadVideo(
      File video, String userId, String productId) async {
    String filePath =
        'products/$userId/$productId/videos/${DateTime.now().millisecondsSinceEpoch}.mp4';
    TaskSnapshot snapshot = await _storage.ref(filePath).putFile(video);
    return await snapshot.ref.getDownloadURL();
  }

  Future<DocumentReference> saveProduct(
      String userID, Map<String, dynamic> productData) async {
    // Simpan produk dan kembalikan DocumentReference
    return await _firestore
        .collection('shops')
        .doc(userID)
        .collection('products')
        .add(productData);
  }

// Mendaftar menjadi seller
  Future<void> registerSeller(
      String userID, String shopName, String shopAddress) async {
    // Menambahkan toko
    await _firestore.collection('shops').doc(userID).set({
      'shopName': shopName,
      'shopAddress': shopAddress,
      'createdAt': Timestamp.now(),
    });

    // Merubah role user
    await _firestore.collection('users').doc(userID).update({
      'role': 'seller',
    });
  }
}
