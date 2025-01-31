import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger _logger = Logger();
  late Future<List<Map<String, dynamic>>> _borrowersData;

  // Fetch borrowers data from Firestore
  Future<List<Map<String, dynamic>>> fetchBorrowers() async {
    try {
      final snapshot = await _firestore.collection('borrowers').get();
      List<Map<String, dynamic>> borrowers = snapshot.docs
          .map((doc) => {
                'name': doc['name'],
                'phone': doc['phone'],
                'email': doc['email'],
              })
          .toList();
      _logger.d("Borrowers data: $borrowers");  // Debug log
      return borrowers;
    } catch (e) {
      _logger.e("Error fetching borrowers: $e");  // Error log
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _borrowersData = fetchBorrowers(); // Fetch borrower data when page loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _borrowersData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            _logger.e("Snapshot error: ${snapshot.error}"); // Log error
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            _logger.w("No borrowers found");  // Log warning
            return const Center(child: Text('No borrowers found.'));
          } else {
            final borrowers = snapshot.data!;
            return ListView.builder(
              itemCount: borrowers.length,
              itemBuilder: (context, index) {
                final borrower = borrowers[index];
                return ListTile(
                  title: Text(borrower['name']),
                  subtitle: Text('Phone: ${borrower['phone']}, Email: ${borrower['email']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
