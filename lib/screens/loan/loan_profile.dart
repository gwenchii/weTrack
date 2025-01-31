import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wetrack/models/loan_model.dart';

class LoanProfilePage extends StatefulWidget {
  final Loan loan;

  const LoanProfilePage({super.key, required this.loan});

  @override
  // ignore: library_private_types_in_public_api
  _LoanProfilePageState createState() => _LoanProfilePageState();
}

class _LoanProfilePageState extends State<LoanProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _loanPurposeController;
  late TextEditingController _loanAmountController;
  late TextEditingController _interestController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing loan data
    _loanPurposeController = TextEditingController(text: widget.loan.loanPurpose);
    _loanAmountController = TextEditingController(text: widget.loan.loanAmount.toString());
    _interestController = TextEditingController(text: widget.loan.interest.toString());
  }

  @override
  void dispose() {
    _loanPurposeController.dispose();
    _loanAmountController.dispose();
    _interestController.dispose();
    super.dispose();
  }

  Future<void> _saveLoanProfile() async {
    if (_formKey.currentState!.validate()) {
      final updatedLoan = {
        'loanPurpose': _loanPurposeController.text,
        'loanAmount': double.tryParse(_loanAmountController.text) ?? 0.0,
        'interest': double.tryParse(_interestController.text) ?? 0.0,
      };

      await FirebaseFirestore.instance.collection('loans').doc(widget.loan.id).update(updatedLoan);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Loan Profile updated')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loan Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _loanPurposeController,
                decoration: const InputDecoration(labelText: 'Loan Purpose'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter the loan purpose' : null,
              ),
              TextFormField(
                controller: _loanAmountController,
                decoration: const InputDecoration(labelText: 'Loan Amount'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Please enter the loan amount' : null,
              ),
              TextFormField(
                controller: _interestController,
                decoration: const InputDecoration(labelText: 'Interest Rate'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Please enter the interest rate' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveLoanProfile,
                child: const Text('Update Loan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
