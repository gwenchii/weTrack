import 'package:flutter/material.dart';
import 'package:wetrack/screens/home/home_page.dart';
import 'package:wetrack/screens/loan/createloan_page.dart';
import 'package:wetrack/widgets/navigation_bar.dart';
import 'package:wetrack/screens/home/dashboard_page.dart'; // Import your actual screens here
import 'package:wetrack/screens/profile/userprofile_page.dart';
import 'package:wetrack/screens/calculator/compound_interest.dart';
// Import for date formatting

class CreateBorrowerPage extends StatefulWidget {
  const CreateBorrowerPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateBorrowerPageState createState() => _CreateBorrowerPageState();
}

class _CreateBorrowerPageState extends State<CreateBorrowerPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _loanPurposeController = TextEditingController();
  final TextEditingController _paymentMethodController = TextEditingController();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();

  int _selectedIndex = 3; // Set to "Create Borrower" tab initially
  List<Map<String, dynamic>> terms = [
    {"date": DateTime.now(), "amount": 0.0}, // Default term with date and amount
  ];

  // Function to add another term (with date and amount)
  void _addAnotherTerm() {
    setState(() {
      terms.add({"date": DateTime.now(), "amount": 0.0});
    });
  }

  // Function to select a date for each term
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

  // Function for navigation handling
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
          MaterialPageRoute(builder: (context) => const CompoundInterest()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CreateBorrowerPage()),
        );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This removes the back button space
        title: const Row(
          children: [
            Expanded(
              child: Text(
                'Create New Loan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.qr_code_scanner),
              ),
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
                      MaterialPageRoute(builder: (context) => const CreateBorrowerPage()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    alignment: Alignment.center,
                    child: Text(
                      'Borrower',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
               GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CreateLoanPage()),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      alignment: Alignment.center,
                      child: Text(
                        'Loan',
                        style: Theme.of(context).textTheme.bodyMedium,
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
                "Borrower's Profile",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 10),
            _buildTextField('Name*', _nameController),
            _buildTextField('Phone*', _phoneController),
            _buildTextField('Email', _emailController),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Loan Profile",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 10),
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
            // Dynamically generated term fields (date and amount)
            Column(
              children: List.generate(
                terms.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0), // Added spacing
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
              onPressed: () {},
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
            borderSide: const BorderSide(
                color: Color(0xFF585656), width: 2),
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
              labelText: "Date", // Changed to "Date"
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
