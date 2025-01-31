import 'package:flutter/material.dart';
import 'package:wetrack/screens/home/home_page.dart';
import 'package:wetrack/screens/profile/settings.dart';
import 'package:wetrack/widgets/navigation_bar.dart';
import 'package:wetrack/screens/home/dashboard_page.dart'; // Import Dashboard
import 'package:wetrack/screens/loan/createborrower_page.dart'; // Import Create Borrower
import 'package:wetrack/screens/calculator/compound_interest.dart'; // Import Calculator

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  int _selectedIndex = 4; // Profile Page is selected

  // Define a function to navigate to the screens
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CompoundInterestPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateBorrowerPage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsPage()),
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
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Terms and Conditions Box
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Effective Date: February 01, 2025\n\n"
                    "WeTrack is a mobile application designed to assist users in tracking their loan expenses and calculating various types of interest. By accessing or using the WeTrack app, you agree to comply with and be bound by these Terms and Conditions. Please read these Terms carefully before using the App. If you do not agree with these Terms, you should not access or use the App.\n\n"
                    "1. Acceptance of Terms\n"
                    "By installing, accessing, or using the App, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions. We may update or modify these Terms at any time, and the revised version will be posted within the App or on our website. It is your responsibility to review these Terms regularly.\n\n"
                    "2. Use of the App\n"
                    "WeTrack is provided as a tool for personal use, enabling users to track loan expenses and calculate loan interest.\n"
                    "The App allows users to input loan details, track payments, and calculate simple or compound interest based on the data entered.\n"
                    "The App is intended for general informational purposes only. Any financial calculations made through the App are estimates based on the data provided by the user and may not reflect the exact figures used by financial institutions or banks.\n\n"
                    "3. No Affiliation with Banks or Financial Institutions\n"
                    "WeTrack is an independent third-party application and is not affiliated with any banks or financial institutions. We do not provide financial services or engage in any banking activities.\n"
                    "The App does not have access to your personal banking information or loan accounts. All information entered by the user is stored solely on the user's device.\n\n"
                    "4. User Responsibilities\n"
                    "You agree to use the App in compliance with all applicable laws, regulations, and guidelines.\n"
                    "You are solely responsible for any information you input into the App, including loan details, payments, and other financial data.\n"
                    "You must ensure that the data you provide is accurate and up to date. WeTrack does not guarantee the accuracy of the information provided by the user.\n\n"
                    "5. Limitation of Liability\n"
                    "WeTrack is provided \"as is,\" and we make no representations or warranties regarding the functionality, performance, or availability of the App.\n"
                    "We are not responsible for any losses, damages, or liabilities incurred by using the App, including but not limited to financial losses, inaccurate calculations, or any damages arising from reliance on the information provided by the App.\n"
                    "We do not guarantee the accuracy or completeness of the interest calculations, as these are based on user-provided information and may not match actual financial figures used by banks or financial institutions.\n\n"
                    "6. Termination of Access\n"
                    "We reserve the right to suspend or terminate your access to the App at any time, without notice, if we believe that you have violated these Terms or engaged in any activity that may harm the integrity or security of the App.\n\n"
                    "7. Governing Law\n"
                    "These Terms and Conditions shall be governed by and construed in accordance with the laws of the jurisdiction in which you reside, without regard to its conflict of law principles.\n\n"
                    "8. Dispute Resolution\n"
                    "In the event of any dispute arising out of or related to these Terms, you agree to first attempt to resolve the matter informally through communication with us. If the dispute cannot be resolved informally, it shall be submitted to binding arbitration in accordance with the laws of your jurisdiction.\n\n"
                    "9. Indemnity\n"
                    "You agree to indemnify, defend, and hold harmless WeTrack, its officers, directors, employees, and agents from and against any claims, damages, liabilities, losses, or expenses arising from your use of the App, your violation of these Terms, or your violation of any third-party rights.\n\n"
                    "10. Changes to the Terms\n"
                    "We may update these Terms at any time. Any changes will be posted in the App or on our website, and the revised terms will become effective as soon as they are posted. Your continued use of the App after any changes to the Terms constitutes your acceptance of the new Terms.",
                    style: TextStyle(
                      fontSize: 16,
                      height: 2, // Line height for better readability
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
