import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NewProductPage extends StatefulWidget {
  final String userId; // Tambahkan userID untuk toko spesifik
  const NewProductPage({super.key, required this.userId});

  @override
  _NewProductPageState createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _typeShoesController = TextEditingController();
  final _stokController = TextEditingController();

  List<File> _images = [];
  File? _video;

  // Fungsi untuk memilih gambar
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null && _images.length < 5) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  // Fungsi untuk memilih video
  Future<void> _pickVideo() async {
    final pickedFile =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
      });
    }
  }

  // Fungsi untuk upload gambar ke Firebase Storage
  Future<List<String>> uploadImages(List<File> images, String userId, String productId) async {
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

  // Fungsi untuk upload video ke Firebase Storage
  Future<String> uploadVideo(File video, String userId, String productId) async {
    String filePath =
        'products/$userId/$productId/videos/${DateTime.now().millisecondsSinceEpoch}.mp4';
    TaskSnapshot snapshot = await _storage.ref(filePath).putFile(video);
    return await snapshot.ref.getDownloadURL();
  }

  // Fungsi untuk menyimpan detail produk ke Firestore dan mengembalikan productId
  Future<String> saveDetailProduct(String userID, Map<String, dynamic> productData) async {
    DocumentReference productRef = await _firestore
        .collection('shops')
        .doc(userID)
        .collection('products')
        .add(productData);

    return productRef.id; // Kembalikan ID produk yang baru dibuat
  }

  // Fungsi untuk memperbarui media produk dengan productId tertentu
  Future<DocumentReference> saveMediaProduct(
      String userID, String productId, Map<String, dynamic> productData) async {
    DocumentReference productRef = _firestore
        .collection('shops')
        .doc(userID)
        .collection('products')
        .doc(productId);

    await productRef.set(productData, SetOptions(merge: true));
    return productRef;
  }

  // Fungsi untuk submit form produk baru
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Data produk awal
        Map<String, dynamic> productData = {
          'name': _nameController.text,
          'description': _descriptionController.text,
          'price': double.parse(_priceController.text),
          'type': _typeShoesController.text,
          'stok': int.parse(_stokController.text),
          'createdAt': Timestamp.now(),
        };

        // Simpan detail produk untuk mendapatkan ID produk
        String productId = await saveDetailProduct(widget.userId, productData);

        // Upload gambar dan video ke Firebase Storage
        List<String> imageUrls = await uploadImages(_images, widget.userId, productId);
        String? videoUrl = _video != null ? await uploadVideo(_video!, widget.userId, productId) : null;

        // Data untuk menyimpan URL gambar dan video
        Map<String, dynamic> mediaData = {
          'images': imageUrls,
          if (videoUrl != null) 'video': videoUrl,
        };

        // Simpan media URL ke Firestore
        await saveMediaProduct(widget.userId, productId, mediaData);

        // Beri feedback ke pengguna
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produk berhasil ditambahkan!'))
        );

        Navigator.pop(context);
      } catch (error) {
        // Tampilkan pesan error jika terjadi kesalahan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambahkan produk: $error'))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Produk Baru")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
                validator: (value) =>
                    value!.isEmpty ? 'Masukkan nama produk' : null,
              ),
              TextFormField(
                controller: _typeShoesController,
                decoration: const InputDecoration(labelText: 'Jenis Sepatu'),
                validator: (value) =>
                    value!.isEmpty ? 'Masukkan jenis sepatu' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? 'Masukkan deskripsi produk' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Masukkan harga produk' : null,
              ),
              TextFormField(
                controller: _stokController,
                decoration: const InputDecoration(labelText: "Stok sepatu"),
                validator: (value) =>
                    value!.isEmpty ? "Masukkan stok sepatu" : null,
              ),
              const SizedBox(height: 16),
              const Text("Gambar (Maksimal 5):"),
              Wrap(
                spacing: 8,
                children: [
                  ..._images.map((image) => Image.file(image, width: 100, height: 100)),
                  IconButton(
                    icon: const Icon(Icons.add_a_photo),
                    onPressed: _pickImage,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text("Video (Maksimal 1):"),
              _video != null
                  ? const Text("Video terpilih")
                  : IconButton(
                      icon: const Icon(Icons.video_library),
                      onPressed: _pickVideo,
                    ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Simpan Produk'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
