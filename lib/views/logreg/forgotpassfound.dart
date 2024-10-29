import 'package:flutter/material.dart';
import 'package:shoes/views/logreg/signinempty.dart';

class forgotpassfound extends StatelessWidget {
  const forgotpassfound({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              Align(
                alignment: Alignment.centerRight, // Mengatur gambar ke kanan
                child: Image.asset(
                  'assets/shoeslogo.jpg',
                  height: 80,
                ),
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerRight, // Mengatur teks ke kanan
                child: Text(
                  'Welcome Back,\nExplorer!',
                  textAlign: TextAlign.right, // Teks diratakan ke kanan
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              // const Text(
              //   'Email Address',
              //   style: TextStyle(
              //     color: Colors.grey,
              //   ),
              // ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  labelStyle: TextStyle(color: Colors.grey),
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              // const Text(
              //   'Enter New Password',
              //   style: TextStyle(
              //     color: Colors.grey,
              //   ),
              // ),
              const SizedBox(height: 8),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Enter New PAssword',
                  labelStyle: TextStyle(color: Colors.grey),
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const signinempty()));
                    // Tambahkan navigasi atau aksi di sini
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1F41BB),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
