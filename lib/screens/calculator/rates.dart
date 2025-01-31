import 'package:flutter/material.dart';
import 'package:wetrack/screens/calculator/compound_interest.dart';
import 'package:wetrack/screens/calculator/simple_interest.dart';
import 'package:wetrack/screens/calculator/terms.dart';
import 'package:wetrack/screens/home/dashboard_page.dart';
import 'package:wetrack/screens/home/home_page.dart';
import 'package:wetrack/screens/loan/createborrower_page.dart';
import 'package:wetrack/screens/profile/userprofile_page.dart';
import 'package:wetrack/widgets/navigation_bar.dart';

class Rates extends StatefulWidget {
  const Rates({super.key});

  @override
  State<Rates> createState() => _RatesState();
}

class _RatesState extends State<Rates> {
  final _initialAmountController = TextEditingController();
  final _finalAmountController = TextEditingController();
  final _repaymentTermsController = TextEditingController();

  bool _isAnnual = true;
  bool _isMonthly = false;

  double percentageRate = 0.0;

  String _selectedCalculator = 'Interest Rate';
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Rates()));
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

  void _calculateInterestRate() {
    final initialAmount = double.tryParse(_initialAmountController.text) ?? 0.0;
    final finalAmount = double.tryParse(_finalAmountController.text) ?? 0.0;
    final repaymentTerms = int.tryParse(_repaymentTermsController.text) ?? 0;

    if (initialAmount == 0 || finalAmount == 0 || repaymentTerms == 0) {
      return;
    }

    // Calculate interest and rate using the formula for annual interest
    double totalInterest = finalAmount - initialAmount;
    
    // If 'Monthly' is selected, repaymentTerms are in months
    // If 'Annual' is selected, repaymentTerms are in years
    num years = _isMonthly ? repaymentTerms / 12.0 : repaymentTerms;  // Convert months to years if monthly is selected

    // Calculate the interest rate per year
    percentageRate = (totalInterest / initialAmount) / years * 100;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Expanded(child: Text('Payment Term Calculator', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown box for Interest Rate at the top left
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
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SimpleInterestPage()));
                          break;
                        case 'Compound Interest':
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CompoundInterestPage()));
                          break;
                        case 'Interest Rate':
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Rates()));
                          break;
                        case 'Payment Term':
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TermsPage()));
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
                    _initialAmountController.clear();
                    _finalAmountController.clear();
                    _repaymentTermsController.clear();
                    setState(() {
                      percentageRate = 0.0;
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
            // Input fields for Initial Amount, Final Amount, and Repayment Terms
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
                            'Annual',
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                          leading: Radio<bool>(
                            value: true,
                            groupValue: _isAnnual,
                            onChanged: (value) {
                              setState(() {
                                _isAnnual = value!;
                                _isMonthly = !value;
                                _calculateInterestRate();  // Recalculate when changing radio
                              });
                            },
                          ),
                        ),
                      ),
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
                                _isAnnual = !value;
                                _calculateInterestRate();  // Recalculate when changing radio
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: _initialAmountController,
                    decoration: const InputDecoration(labelText: 'Initial Amount', labelStyle: TextStyle(color: Colors.black)),
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  TextField(
                    controller: _finalAmountController,
                    decoration: const InputDecoration(labelText: 'Final Amount', labelStyle: TextStyle(color: Colors.black)),
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  TextField(
                    controller: _repaymentTermsController,
                    decoration: const InputDecoration(labelText: 'Repayment Terms', labelStyle: TextStyle(color: Colors.black)),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: _calculateInterestRate,
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 67, 132, 83)),
                child: const Text('Calculate', style: TextStyle(color: Color.fromARGB(255, 247, 247, 247))),
              ),
            ),
            const SizedBox(height: 10),
            // Results Box - Adjusted content and size
            if (percentageRate > 0)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F0F0),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 348,
                height: 125,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align "Results" to the left
                  children: [
                    const Text(
                      'Results',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    // Center-align the "Interest per (month or year)" text
                    Center(
                      child: Text(
                        'Interest per ${_isMonthly ? 'month' : 'year'} ${percentageRate.toStringAsFixed(2)}%',
                        style: const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ],
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
}
