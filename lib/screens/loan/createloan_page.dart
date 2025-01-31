import 'package:flutter/material.dart';
import 'package:wetrack/screens/calculator/simple_interest.dart';
import 'package:wetrack/screens/home/home_page.dart';
import 'package:wetrack/screens/loan/Profiles/loan_profile.dart';
import 'package:wetrack/screens/loan/createborrower_page.dart';
import 'package:wetrack/screens/profile/settings.dart';
import 'package:wetrack/widgets/navigation_bar.dart';
import 'package:wetrack/screens/home/dashboard_page.dart';
import 'package:wetrack/models/loan_model.dart'; // Ensure you import the Loan model

class CreateLoanPage extends StatefulWidget {
  const CreateLoanPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateLoanPageState createState() => _CreateLoanPageState();
}

class _CreateLoanPageState extends State<CreateLoanPage> {
  final TextEditingController _loanProviderController = TextEditingController();
  final TextEditingController _loanPurposeController = TextEditingController();
  final TextEditingController _paymentMethodController = TextEditingController();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();

  int _selectedIndex = 3;
  List<Map<String, dynamic>> terms = [
    {"date": DateTime.now(), "amount": 0.0},
  ];

  void _addAnotherTerm() {
    setState(() {
      terms.add({"date": DateTime.now(), "amount": 0.0});
    });
  }

  Future<void> _selectDate(int index) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: terms[index]["date"],
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null && selectedDate != terms[index]["date"]) {
      setState(() {
        terms[index]["date"] = selectedDate;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SimpleInterestPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CreateLoanPage()),
        );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SettingsPage()),
        );
        break;
      default:
        break;
    }
  }

  // Method to handle loan profile creation and navigation
  void _createLoanProfile() {
      final loan = Loan(
      loanId: 'some_unique_id',  // You need to generate or retrieve a unique loanId
      loanProvider: _loanProviderController.text,
      loanPurpose: _loanPurposeController.text,
      paymentMethod: _paymentMethodController.text,
      loanAmount: double.tryParse(_loanAmountController.text) ?? 0.0,
      interest: double.tryParse(_interestController.text) ?? 0.0,
      isPaid: false,  // Set the isPaid parameter (e.g., false for unpaid loans)
      createdAt: DateTime.now(),
      terms: terms,  // Make sure 'terms' is defined
    );


    // Pass the loan object to the LoanProfilePage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoanProfilePage(loan: loan),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Text(
              'Create New Loan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.qr_code_scanner),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateBorrowerPage()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    alignment: Alignment.center,
                    child: Text(
                      'Borrower',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateLoanPage()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    alignment: Alignment.center,
                    child: Text(
                      'Loan',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Loan Details",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 10),
            _buildTextField('Loan Provider*', _loanProviderController),
            _buildTextField('Loan Purpose*', _loanPurposeController),
            _buildTextField('Payment Method*', _paymentMethodController),
            _buildTextField('Loan Amount*', _loanAmountController),
            _buildTextField('Interest*', _interestController),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Set Up Payment Terms",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: List.generate(
                terms.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      _buildDateField(index),
                      const SizedBox(width: 11),
                      _buildAmountField(index),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _addAnotherTerm,
                child: Text(
                  "+ Add Another Term",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _createLoanProfile, // Updated to use the new method
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color(0xFF97E2AA),
                fixedSize: const Size(344, 32),
              ),
              child: Text(
                'Create Loan Profile',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
          filled: true,
          fillColor: const Color(0xFFF6F0F0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF585656), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF585656), width: 2),
          ),
        ),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 12,
            ),
      ),
    );
  }

  Widget _buildDateField(int index) {
    return SizedBox(
      width: 100,
      child: GestureDetector(
        onTap: () => _selectDate(index),
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Date",
              labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
              prefixIcon: const Icon(Icons.calendar_today),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAmountField(int index) {
    return SizedBox(
      width: 265,
      child: TextFormField(
        initialValue: terms[index]["amount"].toString(),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            terms[index]["amount"] = double.tryParse(value) ?? 0.0;
          });
        },
        decoration: InputDecoration(
          labelText: 'Insert Amount',
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}