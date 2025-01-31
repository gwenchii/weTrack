import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wetrack/models/borrower_model.dart'; // Import the Borrower model

class BorrowerProfilePage extends StatefulWidget {
  final Borrower borrower; // Accepting Borrower as a parameter

  const BorrowerProfilePage({super.key, required this.borrower});

  @override
  // ignore: library_private_types_in_public_api
  _BorrowerProfilePageState createState() => _BorrowerProfilePageState();
}

class _BorrowerProfilePageState extends State<BorrowerProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.borrower.name);
    _phoneController = TextEditingController(text: widget.borrower.phone);
    _emailController = TextEditingController(text: widget.borrower.email);
  }

  // Function to update borrower profile in Firestore
  Future<void> _updateBorrowerProfile() async {
    final name = _nameController.text;
    final phone = _phoneController.text;
    final email = _emailController.text;

    if (_formKey.currentState!.validate()) {
      try {
        // Reference to existing borrower document
        final borrowerRef = FirebaseFirestore.instance
            .collection('borrowers')
            .doc(widget.borrower.id);

        await borrowerRef.update({
          'name': name,
          'phone': phone,
          'email': email,
        });

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.borrower.name}\'s Profile'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  filled: true,
                  fillColor: Color(0xFFF6F0F0),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 16.0),

              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  filled: true,
                  fillColor: Color(0xFFF6F0F0),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
              ),
              const SizedBox(height: 16.0),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Color(0xFFF6F0F0),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
              ),
              const SizedBox(height: 20.0),

              ElevatedButton(
                onPressed: _updateBorrowerProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF97E2AA),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Update Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
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
