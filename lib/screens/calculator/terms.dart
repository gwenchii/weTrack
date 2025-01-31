import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:wetrack/screens/home/dashboard_page.dart';
import 'package:wetrack/screens/home/home_page.dart';
import 'package:wetrack/screens/loan/createborrower_page.dart';
import 'package:wetrack/screens/profile/userprofile_page.dart';
import 'package:wetrack/widgets/navigation_bar.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  final _totalAmountController = TextEditingController();
  final _repaymentTermsController = TextEditingController();

  bool _isMonthly = true;
  double _amountPerTerm = 0.0;
  final List<Map<String, dynamic>> _paymentSchedule = [];
  DateTime? _firstPaymentDate;

  String _selectedCalculator = 'Payment Term';
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TermsPage()));
        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CreateBorrowerPage()));
        break;
      case 4:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
        break;
      default:
        break;
    }
  }

  void _selectFirstPaymentDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _firstPaymentDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _firstPaymentDate) {
      setState(() {
        _firstPaymentDate = picked;
        _calculatePaymentSchedule();  // Recalculate when the date changes
      });
    }
  }

void _calculatePaymentSchedule() {
  final totalAmount = double.tryParse(_totalAmountController.text) ?? 0.0;
  final repaymentTerms = int.tryParse(_repaymentTermsController.text) ?? 0;

  if (totalAmount == 0 || repaymentTerms == 0 || _firstPaymentDate == null) {
    return;
  }

  // Calculate the amount per term
  _amountPerTerm = totalAmount / repaymentTerms;

  // Generate the payment schedule
  _paymentSchedule.clear();
  DateTime currentDate = _firstPaymentDate!;

  // Use DateFormat to format the dates in the desired format
  // ignore: unused_local_variable
  final dateFormat = DateFormat('MMMM dd, yyyy'); // e.g. "January 02, 2022"

  for (int i = 0; i < repaymentTerms; i++) {
    _paymentSchedule.add({
      'term': (i + 1).toString(),
      'date': currentDate, // Store DateTime object
      'amount': _amountPerTerm,
    });

    // Add months for monthly payments or 15 days for bi-monthly payments
    if (_isMonthly) {
      // Add 30 days for monthly payment
      currentDate = currentDate.add(const Duration(days: 30)); // Approximate a 30-day month
    } else {
      // Add 15 days for bi-monthly payments
      currentDate = currentDate.add(const Duration(days: 15));
    }
  }

  setState(() {});
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Expanded(child: Text('Payment Terms Calculator', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown box for Payment Term at the top left
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF69D685), // Green color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 200,
                  height: 35,
                  child: DropdownButton<String>(
                    value: _selectedCalculator,
                    items: const [
                      DropdownMenuItem(value: 'Simple Interest', child: Text('Simple Interest')),
                      DropdownMenuItem(value: 'Compound Interest', child: Text('Compound Interest')),
                      DropdownMenuItem(value: 'Interest Rate', child: Text('Interest Rate')),
                      DropdownMenuItem(value: 'Payment Term', child: Text('Payment Term')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedCalculator = value!;
                      });

                      // Navigate to the respective page based on dropdown selection
                      switch (_selectedCalculator) {
                        case 'Simple Interest':
                          // Add navigation logic for Simple Interest
                          break;
                        case 'Compound Interest':
                          // Add navigation logic for Compound Interest
                          break;
                        case 'Interest Rate':
                          // Add navigation logic for Interest Rate
                          break;
                        case 'Payment Term':
                          // Already on Payment Term page
                          break;
                        default:
                          break;
                      }
                    },
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                    isExpanded: true,
                    underline: const SizedBox(),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Clear all fields logic
                    _totalAmountController.clear();
                    _repaymentTermsController.clear();
                    setState(() {
                      _paymentSchedule.clear();
                      _amountPerTerm = 0.0;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Text(
                      'Clear',
                      style: TextStyle(color: Color.fromARGB(255, 102, 102, 102), fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            // Input fields for Total Amount, Repayment Terms, and First Payment Date
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F0F0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text(
                            'Monthly',
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                          leading: Radio<bool>(
                            value: true,
                            groupValue: _isMonthly,
                            onChanged: (value) {
                              setState(() {
                                _isMonthly = value!;
                                _calculatePaymentSchedule();  // Recalculate when changing radio
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text(
                            'Bi-Monthly',
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                          leading: Radio<bool>(
                            value: false,
                            groupValue: _isMonthly,
                            onChanged: (value) {
                              setState(() {
                                _isMonthly = value!;
                                _calculatePaymentSchedule();  // Recalculate when changing radio
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  TextField(
                    controller: _totalAmountController,
                    decoration: const InputDecoration(labelText: 'Total Amount', labelStyle: TextStyle(color: Colors.black)),
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  TextField(
                    controller: _repaymentTermsController,
                    decoration: const InputDecoration(labelText: 'Repayment Terms', labelStyle: TextStyle(color: Colors.black)),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: _selectFirstPaymentDate,
                    child: AbsorbPointer(
                      child: TextField(
                        controller: TextEditingController(text: _firstPaymentDate == null ? '' : DateFormat('MMMM dd, yyyy').format(_firstPaymentDate!)),
                        decoration: const InputDecoration(labelText: 'First Payment Date', labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: _calculatePaymentSchedule,
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 67, 132, 83)),
                child: const Text('Calculate', style: TextStyle(color: Color.fromARGB(255, 247, 247, 247))),
              ),
            ),
            const SizedBox(height: 10),
            // Results Box - Payment Schedule
            if (_paymentSchedule.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F0F0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment Schedule',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    for (int i = 0; i < _paymentSchedule.length; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${_paymentSchedule[i]['term']}', style: const TextStyle(color: Colors.black)),
                          Text(DateFormat('MMMM dd, yyyy').format(_paymentSchedule[i]['date']), style: const TextStyle(color: Colors.black)),
                          Text('₱${_paymentSchedule[i]['amount'] == _paymentSchedule[i]['amount'].toInt() ? '${_paymentSchedule[i]['amount'].toInt()}' : _paymentSchedule[i]['amount'].toStringAsFixed(2)}', style: const TextStyle(color: Colors.black)),
                        ],
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar( // Use your custom navigation bar here
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
