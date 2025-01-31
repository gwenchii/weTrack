// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wetrack/models/loan_model.dart';
import 'package:intl/intl.dart';
import 'package:wetrack/models/loan_model.dart';
import 'package:wetrack/widgets/navigation_bar.dart';
import 'package:wetrack/screens/home/home_page.dart';
import 'package:wetrack/screens/home/dashboard_page.dart';
import 'package:wetrack/screens/calculator/simple_interest.dart';
import 'package:wetrack/screens/loan/createborrower_page.dart';
import 'package:wetrack/screens/profile/settings.dart';

class LoanProfilePage extends StatefulWidget {
<<<<<<< HEAD
  final Map<String, String> borrower;
  const LoanProfilePage({super.key, required this.borrower, required Loan loan});

  @override
=======
  final Loan loan;
  final Loan loan;
  const LoanProfilePage({super.key, required this.loan});

  @override
  // ignore: library_private_types_in_public_api
  // ignore: library_private_types_in_public_api
>>>>>>> 4196bcf6b38c34a7eb0b24cc91dbbb3902109647
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
<<<<<<< HEAD
    // Replace this with actual logic for calculating total paid based on payment terms.
    totalPaid = 0.0; // Update with actual logic if necessary
=======
    totalPaid = loan.terms
        .where((term) => term["paid"] == true)
        .fold(0.0, (sum, term) => sum + term["amount"]);
  }

  void _uploadProofOfPayment(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      print("File uploaded: ${file.name}");
      setState(() {
        loan.terms[index]["paid"] = true;
        loan.terms[index]["proofFile"] = file.name;
        remainingBalance -= loan.terms[index]["amount"];
        totalPaid += loan.terms[index]["amount"];
      });
    } else {
      print("No file selected.");
    }
>>>>>>> 4196bcf6b38c34a7eb0b24cc91dbbb3902109647
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: Text('${borrower['loanProvider']?.toUpperCase()} Loan'),
=======
        title: Text('${loan.loanProvider.toUpperCase()} Loan'),
        title: Text('${loan.loanProvider.toUpperCase()} Loan'),
>>>>>>> 4196bcf6b38c34a7eb0b24cc91dbbb3902109647
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
<<<<<<< HEAD
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
=======
        currentIndex: 3,
        onTap: (index) {},
        currentIndex: 3,
        onTap: (index) {},
>>>>>>> 4196bcf6b38c34a7eb0b24cc91dbbb3902109647
      ),
    );
  }

  Widget _buildLoanDetails() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F0F0),
        color: const Color(0xFFF6F0F0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
<<<<<<< HEAD
          _buildDetailRow('Loan Purpose', borrower['loanPurpose'] ?? 'N/A'),
          _buildDetailRow('Payment Method', borrower['paymentMethod'] ?? 'N/A'),
          _buildDetailRow('Loan Amount', 'Php${remainingBalance.toStringAsFixed(2)}'),
          _buildDetailRow('Interest', '${borrower['interest']}%'),
=======
          _buildDetailRow('Loan Purpose', loan.loanPurpose),
          _buildDetailRow('Payment Method', loan.paymentMethod),
          _buildDetailRow(
              'Loan Amount', 'Php${loan.loanAmount.toStringAsFixed(2)}'),
          _buildDetailRow('Interest', '${loan.interest}%'),
>>>>>>> 4196bcf6b38c34a7eb0b24cc91dbbb3902109647
          const Divider(),
          _buildDetailRow('Amount Paid', 'Php${totalPaid.toStringAsFixed(2)}'),
          _buildDetailRow(
              'Balance Remaining', 'Php${remainingBalance.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        Text(value, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildPaymentSchedule() {
    final dateFormat = DateFormat('MMMM dd, yyyy');
<<<<<<< HEAD
    // Assuming that payment terms are in the borrower map, use them here.
    // Modify this part as needed for actual payment schedule data.
=======
    final dateFormat = DateFormat('MMMM dd, yyyy');
>>>>>>> 4196bcf6b38c34a7eb0b24cc91dbbb3902109647
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text('Payment Schedule',
            style: TextStyle(fontWeight: FontWeight.bold)),
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
<<<<<<< HEAD
            width: double.infinity,
            height: 85,
=======
            width: double.infinity, // Adjusted width for responsiveness
            height: 85, // Adjusted height to accommodate more content
>>>>>>> 4196bcf6b38c34a7eb0b24cc91dbbb3902109647
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
<<<<<<< HEAD
                const Text(
                  "Not Paid", // Update based on actual data
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
=======
                GestureDetector(
                  onTap: () => _uploadProofOfPayment(i),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      (loan.terms[i]["paid"] ?? false)
                          ? "Paid"
                          : "Upload Proof of Payment",
                      style: TextStyle(
                        color: (loan.terms[i]["paid"] ?? false)
                            ? Colors.green
                            : Colors.blue,
                        fontSize: 12,
                      ),
                    ),
>>>>>>> 4196bcf6b38c34a7eb0b24cc91dbbb3902109647
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
