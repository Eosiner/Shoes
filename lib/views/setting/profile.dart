import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes/views/logreg/signinempty.dart';
import 'package:shoes/views/setting/alamat.dart';
import 'package:shoes/views/setting/editprofil.dart';
import 'package:shoes/views/belanja/keranjang_fill.dart';

class Profile extends StatelessWidget {
  final String userID;
  Profile({super.key, required this.userID});

  Future<void> logout(BuildContext  context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('userID');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const signinempty())
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 115,
        backgroundColor: Colors.white,
        title: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(userID) // Pastikan userID terdefinisi dengan benar
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return const Center(child: Text('Error loading profile'));
              }

              var userData = snapshot.data!;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: userData['photoURL'] != null
                        ? NetworkImage(userData['photoURL'])
                        : const AssetImage('assets/default_profile.jpeg'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hallo, ${userData['name']}', // Nama dari Firestore
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Opacity(
                        opacity: 0.8,
                        child: Text(
                          '@${userData['name'] ?? 'ucup'}', // Username dari Firestore
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                     logout(context);
                    },
                    icon: const Icon(Icons.logout, size: 34,) 
                  ),
                ],
              );
            }),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
        children: [
          // Bagian Akun
          const ListTile(
            title: Text(
              'Akun',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20, // Ukuran teks lebih besar
              ),
            ),
          ),
          ListTile(
            title: const Text('Edit Profil'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => editprofil()));
            },
          ),
          ListTile(
            title: const Text('Dana'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Aksi Dana
            },
          ),
          ListTile(
            title: const Text('Gopay'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Aksi Gopay
            },
          ),
          ListTile(
            title: const Text('Orderan Kamu'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => keranjang_fill()));
            },
          ),
          ListTile(
            title: const Text('Alamat'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => alamat()));
            },
          ),
          ListTile(
            title: const Text('Bantuan'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Aksi Bantuan
            },
          ),
          const ListTile(
            title: Text(
              'General',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20, // Ukuran teks lebih besar
              ),
            ),
          ),
          ListTile(
            title: const Text('Privacy & Policy'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Aksi Bantuan
            },
          ),
          ListTile(
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Aksi Bantuan
            },
          ),
          ListTile(
            title: const Text('RateApp'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Aksi Bantuan
            },
          ),
        ],
      ),
    );
  }
}
