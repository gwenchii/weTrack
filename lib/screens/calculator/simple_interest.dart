import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wetrack/screens/calculator/compound_interest.dart';
import 'package:wetrack/screens/calculator/rates.dart';
import 'package:wetrack/screens/calculator/terms.dart';
import 'package:wetrack/screens/home/dashboard_page.dart';
import 'package:wetrack/screens/home/home_page.dart';
import 'package:wetrack/screens/loan/createborrower_page.dart';
import 'package:wetrack/screens/profile/userprofile_page.dart';
import 'package:wetrack/widgets/navigation_bar.dart';

class SimpleInterestPage extends StatefulWidget {
  const SimpleInterestPage({super.key});

  @override
  State<SimpleInterestPage> createState() => _SimpleInterestPageState();
}

class _SimpleInterestPageState extends State<SimpleInterestPage> {
  final _initialAmountController = TextEditingController();
  final _interestRateController = TextEditingController();
  final _repaymentTermsController = TextEditingController();
  final _firstPaymentDateController = TextEditingController();

  bool _isMonthly = true;
  bool _isBiMonthly = false;

  double monthlyPayment = 0.0;
  double totalInterest = 0.0;
  double totalRepaymentAmount = 0.0;
  int repaymentTerms = 0;
  List<Map<String, dynamic>> paymentSchedule = [];

  String _selectedCalculator = 'Simple Interest';
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SimpleInterestPage()));
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

  void _calculateSimpleInterest() {
    final initialAmount = double.tryParse(_initialAmountController.text) ?? 0.0;
    final interestRate = double.tryParse(_interestRateController.text) ?? 0.0;
    repaymentTerms = int.tryParse(_repaymentTermsController.text) ?? 0;
    final firstPaymentDate = DateTime.tryParse(_firstPaymentDateController.text) ?? DateTime.now();

    if (initialAmount == 0 || interestRate == 0 || repaymentTerms == 0) {
      return;
    }

    final interest = (initialAmount * interestRate * repaymentTerms) / 100;
    totalInterest = interest;
    totalRepaymentAmount = initialAmount + interest;

    monthlyPayment = totalRepaymentAmount / repaymentTerms;

    paymentSchedule = List.generate(
      repaymentTerms,
      (index) {
        final paymentDate = firstPaymentDate.add(Duration(days: 30 * (index + 1)));
        return {
          'term': index + 1,
          'date': paymentDate,
          'amount': monthlyPayment,
        };
      },
    );

    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _firstPaymentDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _onDropdownChanged(String? value) {
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
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown box for Simple Interest at the top left
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
                        onChanged: _onDropdownChanged,
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                        isExpanded: true,
                        underline: const SizedBox(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Clear all fields logic
                        _initialAmountController.clear();
                        _interestRateController.clear();
                        _repaymentTermsController.clear();
                        _firstPaymentDateController.clear();
                        setState(() {
                          monthlyPayment = 0.0;
                          totalInterest = 0.0;
                          totalRepaymentAmount = 0.0;
                          repaymentTerms = 0;
                          paymentSchedule.clear();
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
                // Other widgets for inputs, calculations, etc.
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
                                    _isBiMonthly = !value;
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
                                value: true,
                                groupValue: _isBiMonthly,
                                onChanged: (value) {
                                  setState(() {
                                    _isBiMonthly = value!;
                                    _isMonthly = !value;
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
                        controller: _interestRateController,
                        decoration: const InputDecoration(labelText: 'Interest Rate (%)', labelStyle: TextStyle(color: Colors.black)),
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      TextField(
                        controller: _repaymentTermsController,
                        decoration: const InputDecoration(labelText: 'Repayment Terms', labelStyle: TextStyle(color: Colors.black)),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: _firstPaymentDateController,
                            decoration: const InputDecoration(labelText: 'First Payment Date', labelStyle: TextStyle(color: Colors.black)),
                            style: const TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: _calculateSimpleInterest,
                    style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 67, 132, 83)),
                    child: const Text('Calculate', style: TextStyle(color: Color.fromARGB(255, 247, 247, 247))),
                  ),
                ),
                const SizedBox(height: 10),
                // Results Box (F6F0F0)
                if (monthlyPayment > 0)
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
                          'Results',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Monthly Payment:', style: TextStyle(color: Colors.black)),
                            Text('₱${monthlyPayment == monthlyPayment.toInt() ? '${monthlyPayment.toInt()}' : monthlyPayment.toStringAsFixed(2)}', style: const TextStyle(color: Colors.black)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Interest:', style: TextStyle(color: Colors.black)),
                            Text('₱${totalInterest == totalInterest.toInt() ? '${totalInterest.toInt()}' : totalInterest.toStringAsFixed(2)}', style: const TextStyle(color: Colors.black)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Repayment Amount:', style: TextStyle(color: Colors.black)),
                            Text('₱${totalRepaymentAmount == totalRepaymentAmount.toInt() ? '${totalRepaymentAmount.toInt()}' : totalRepaymentAmount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.black)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Repayment Terms:', style: TextStyle(color: Colors.black)),
                            Text('$repaymentTerms', style: const TextStyle(color: Colors.black)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Payment Schedule',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        for (int i = 0; i < paymentSchedule.length; i++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${paymentSchedule[i]['term']}', style: const TextStyle(color: Colors.black)),
                              Text(DateFormat('MMMM dd, yyyy').format(paymentSchedule[i]['date']), style: const TextStyle(color: Colors.black)),
                              Text('₱${paymentSchedule[i]['amount'] == paymentSchedule[i]['amount'].toInt() ? '${paymentSchedule[i]['amount'].toInt()}' : paymentSchedule[i]['amount'].toStringAsFixed(2)}', style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
