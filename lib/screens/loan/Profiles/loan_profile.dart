import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wetrack/models/loan_model.dart';
import 'package:wetrack/widgets/navigation_bar.dart';
import 'package:file_picker/file_picker.dart';

class LoanProfilePage extends StatefulWidget {
  final Loan loan;
  const LoanProfilePage({super.key, required this.loan});

  @override
  // ignore: library_private_types_in_public_api
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
    remainingBalance = loan.loanAmount;
    _calculateTotalPaid();
  }

  void _calculateTotalPaid() {
    totalPaid = loan.terms.where((term) => term["paid"] == true)
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${loan.loanProvider.toUpperCase()} Loan'),
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
        currentIndex: 3,
        onTap: (index) {},
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
          _buildDetailRow('Loan Purpose', loan.loanPurpose),
          _buildDetailRow('Payment Method', loan.paymentMethod),
          _buildDetailRow('Loan Amount', 'Php${loan.loanAmount.toStringAsFixed(2)}'),
          _buildDetailRow('Interest', '${loan.interest}%'),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text('Payment Schedule', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        for (int i = 0; i < loan.terms.length; i++) ...[
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F0F0),
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,  // Adjusted width for responsiveness
            height: 85, // Adjusted height to accommodate more content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(dateFormat.format(loan.terms[i]["date"])),
                    Text(
                      'Php${loan.terms[i]["amount"]}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => _uploadProofOfPayment(i),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      (loan.terms[i]["paid"] ?? false)
                          ? "Paid"
                          : "Upload Proof of Payment",
                      style: TextStyle(
                        color: (loan.terms[i]["paid"] ?? false) ? Colors.green : Colors.blue,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]
      ],
    );
  }
}
