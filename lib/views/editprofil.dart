import 'package:flutter/material.dart';

class editprofil extends StatefulWidget {
  @override
  _editprofilState createState() => _editprofilState();
}

class _editprofilState extends State<editprofil> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final _fullNameController = TextEditingController(text: 'Ucup Satoru');
  final _genderController = TextEditingController(text: 'Male');
  final _birthdayController = TextEditingController(text: '10 - 12 - 2024');
  final _phoneController = TextEditingController(text: '+62 81234567123');
  final _emailController = TextEditingController(text: 'blablabla@gmail.com');
  final _usernameController = TextEditingController(text: '@ucup');

  String? _selectedGender; // Variable to hold the selected gender

  @override
  void initState() {
    super.initState();
    _selectedGender = _genderController.text; // Set initial gender
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Edit Profil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/ppgojo.jpg'),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.black),
                      onPressed: () {
                        // Handle photo change
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildTextField('Full Name', _fullNameController),
              const SizedBox(height: 16), // Adjusted spacing
              Row(
                children: [
                  Expanded(
                    child: _buildGenderDropdown(),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildBirthdayPicker(),
                  ),
                ],
              ),
              const SizedBox(height: 16), // Adjusted spacing
              _buildTextField('Phone Number', _phoneController),
              const SizedBox(height: 16), // Adjusted spacing
              _buildTextField('Email', _emailController),
              const SizedBox(height: 16), // Adjusted spacing
              _buildTextField('Username', _usernameController),
              const SizedBox(height: 20), // Adjusted spacing before the button
              ElevatedButton(
                child: const Text('Simpan', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF275A65),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile updated successfully')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: const InputDecoration(
        labelText: 'Gender',
        border: OutlineInputBorder(),
      ),
      items: <String>['Male', 'Female'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedGender = newValue;
          _genderController.text = newValue!;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your gender';
        }
        return null;
      },
    );
  }

  Widget _buildBirthdayPicker() {
    return TextFormField(
      controller: _birthdayController,
      decoration: InputDecoration(
        labelText: 'Birthday',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () {
            _selectDate(context);
          },
        ),
      ),
      readOnly: true, // Prevent manual editing
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your birthday';
        }
        return null;
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _birthdayController.text = "${pickedDate.day} - ${pickedDate.month} - ${pickedDate.year}";
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _genderController.dispose();
    _birthdayController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }
}
