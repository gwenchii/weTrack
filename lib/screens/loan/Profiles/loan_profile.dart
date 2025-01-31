import 'package:flutter/material.dart';
import 'package:wetrack/models/loan_model.dart'; // Import Loan model
import 'package:wetrack/widgets/navigation_bar.dart';

class LoanProfilePage extends StatefulWidget {
  final Loan loan; // Pass Loan object from the previous screen

  const LoanProfilePage({super.key, required this.loan});

  @override
  _LoanProfilePageState createState() => _LoanProfilePageState();
}

class _LoanProfilePageState extends State<LoanProfilePage> {
  late Loan loan;
  double totalPaid = 0.0;
  double remainingBalance = 0.0;

  @override
  void initState() {
    super.initState();
    loan = widget.loan;
    remainingBalance = loan.loanAmount; // Start with the full loan amount
  }

  // Handle uploading proof of payment (simplified version)
  void _uploadProofOfPayment(int index) {
    // Here, you would implement file upload functionality
    // For simplicity, we'll assume the proof is uploaded and the term is marked as paid
    setState(() {
      loan.terms[index]["amount"] = loan.terms[index]["amount"] - totalPaid;
      remainingBalance -= totalPaid;
      totalPaid = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan #${loan.loanProvider}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              onPressed: () {
                // Handle QR code scanning
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Loan Details
            _buildLoanDetails(),

            const Divider(),

            // Payment Info
            _buildPaymentInfo(),

            const Divider(),

            // Payment Schedule & Upload Proof
            _buildPaymentSchedule(),

            // Upload proof button
            ElevatedButton(
              onPressed: () {
                _uploadProofOfPayment(0); // Example for first term
              },
              child: Text('Upload Proof of Payment'),
            ),

            const SizedBox(height: 20),

            // Remaining balance
            Text(
              'Remaining Balance: \$${remainingBalance.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3, // assuming the current tab is "Create Loan"
        onTap: (index) {
          // Navigation logic for the bottom navigation bar
        },
      ),
    );
  }

  Widget _buildLoanDetails() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Loan Purpose', loan.loanPurpose),
          _buildDetailRow('Payment Method', loan.paymentMethod),
          _buildDetailRow('Loan Amount', '\$${loan.loanAmount}'),
          _buildDetailRow('Interest', '${loan.interest}%'),
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

  Widget _buildPaymentInfo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Amount Paid', '\$${totalPaid.toStringAsFixed(2)}'),
          _buildDetailRow('Balance Remaining', '\$${remainingBalance.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  Widget _buildPaymentSchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Payment Schedule', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        for (int i = 0; i < loan.terms.length; i++) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Term ${i + 1}: ${loan.terms[i]["date"].toString()}'),
              Text('\$${loan.terms[i]["amount"]}'),
            ],
          ),
          const SizedBox(height: 8),
        ]
      ],
    );
  }
}
