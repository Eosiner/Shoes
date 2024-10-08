import 'package:flutter/material.dart';
import 'package:shoes/views/confirmationsignup.dart';
import 'package:shoes/views/signup.dart';

class signupwphoto extends StatelessWidget {
  const signupwphoto({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const signup()));
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Centering the title and photo
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Create New',
                      style: TextStyle(
                        fontSize: 20,

                      ),
                    ),
                    Text(
                      'Your Account',
                      style: TextStyle(
                        fontSize: 20,

                      ),
                    ),
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/ppgojo.jpg'),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),

              // Full Name Field with Label
              const Text(
                'Full Name',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
              const SizedBox(height: 15),

              // Email Address Field with Label
              const Text(
                'Email Address',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
              const SizedBox(height: 15),

              // Password Field with Label
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
              const SizedBox(height: 15),

              // Confirm Password Field with Label
              const Text(
                'Confirm Password',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
              const SizedBox(height: 30),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () { Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const confirmationsignup()));
                    },
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                    backgroundColor: const Color(0xFF1F41BB),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
