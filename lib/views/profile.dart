import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 115,
         // Membuat AppBar lebih tinggi]
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Posisikan semua elemen ke tengah
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: CircleAvatar(
                  radius: 40, // Membesarkan ukuran gambar profil
                  backgroundImage: AssetImage('assets/ppgojo.jpg'), // Gambar ppgojo.jpg
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Posisikan teks di kiri gambar
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hallo, Ucup',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25, // Ukuran teks lebih besar
                      fontWeight: FontWeight.bold, // Teks "Hallo, Ucup" menjadi bold
                    ),
                  ),
                  Opacity(
                    opacity: 0.8,
                    child: Text(
                      '@ucup',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(), // Spacer untuk memberi jarak antara teks dan tombol logout
              IconButton(
                onPressed: () {
                  // Aksi logout
                },
                icon: Image.asset(
                  'assets/logout.jpg', // Gambar logout.jpg
                  width: 35,
                  height: 35,
                ),
              ),
            ],
          ),
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
              // Aksi Edit Profil
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
              // Aksi Orderan Kamu
            },
          ),
          ListTile(
            title: const Text('Alamat'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Aksi Alamat
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