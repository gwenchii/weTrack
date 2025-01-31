// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wetrack/models/loan_model.dart';
import 'package:wetrack/widgets/navigation_bar.dart';
import 'package:wetrack/screens/home/home_page.dart';
import 'package:wetrack/screens/home/dashboard_page.dart';
import 'package:wetrack/screens/calculator/simple_interest.dart';
import 'package:wetrack/screens/loan/createborrower_page.dart';
import 'package:wetrack/screens/profile/settings.dart';

class LoanProfilePage extends StatefulWidget {
  final Map<String, String> borrower;
  const LoanProfilePage({super.key, required this.borrower, required Loan loan});

  @override
  _LoanProfilePageState createState() => _LoanProfilePageState();
}

class _LoanProfilePageState extends State<LoanProfilePage> {
  late Map<String, String> borrower;
  double totalPaid = 0.0;
  double remainingBalance = 0.0;
  int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
    borrower = widget.borrower;
    remainingBalance = double.tryParse(borrower['loanAmount'] ?? '0') ?? 0.0;
    _calculateTotalPaid();
  }

  void _calculateTotalPaid() {
    // Replace this with actual logic for calculating total paid based on payment terms.
    totalPaid = 0.0; // Update with actual logic if necessary
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${borrower['loanProvider']?.toUpperCase()} Loan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLoanDetails(),
            _buildPaymentSchedule(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildLoanDetails() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F0F0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Loan Purpose', borrower['loanPurpose'] ?? 'N/A'),
          _buildDetailRow('Payment Method', borrower['paymentMethod'] ?? 'N/A'),
          _buildDetailRow('Loan Amount', 'Php${remainingBalance.toStringAsFixed(2)}'),
          _buildDetailRow('Interest', '${borrower['interest']}%'),
          const Divider(),
          _buildDetailRow('Amount Paid', 'Php${totalPaid.toStringAsFixed(2)}'),
          _buildDetailRow('Balance Remaining', 'Php${remainingBalance.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        Text(value, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildPaymentSchedule() {
    final dateFormat = DateFormat('MMMM dd, yyyy');
    // Assuming that payment terms are in the borrower map, use them here.
    // Modify this part as needed for actual payment schedule data.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text('Payment Schedule', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        // Placeholder for payment terms. You should update this logic based on actual data.
        // For now, an empty list is shown.
        for (int i = 0; i < 5; i++) ...[ // Example loop for 5 payment terms
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F0F0),
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: 85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(dateFormat.format(DateTime.now().add(Duration(days: i * 7)))), // Example payment date
                    Text(
                      'Php ${(i + 1) * 1000}', // Example amount
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "Not Paid", // Update based on actual data
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ]
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SimpleInterestPage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateBorrowerPage()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
        break;
      default:
        break;
    }
  }
}
