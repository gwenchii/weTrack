import 'package:flutter/material.dart';
import 'package:wetrack/screens/home/home_page.dart';
import 'package:wetrack/screens/profile/settings.dart';
import 'package:wetrack/widgets/navigation_bar.dart';
import 'package:wetrack/screens/home/dashboard_page.dart'; // Import Dashboard
import 'package:wetrack/screens/loan/createborrower_page.dart'; // Import Create Borrower
import 'package:wetrack/screens/calculator/compound_interest.dart'; // Import Calculator

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
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
          'Privacy Policy',
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
            // Privacy Policy Box
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
                    "At WeTrack, we understand the importance of protecting your privacy. This Privacy Policy explains how we collect, use, and safeguard your personal information when you use the WeTrack app. Please review this Privacy Policy to understand how we handle your information.\n\n"
                    "1. Information We Collect\n"
                    "We may collect the following types of information when you use the App:\n"
                    "Personal Information: We do not collect any personally identifiable information unless you explicitly provide it. This includes data such as your name, email address, and phone number if you choose to input it for account-related purposes.\n"
                    "App Usage Data: We collect non-personal data related to your use of the App, such as the features you use, the pages you visit, and the actions you take. This data helps us improve the functionality of the App.\n\n"
                    "2. How We Use Your Information\n"
                    "We use the information we collect to:\n"
                    "Provide and enhance the functionality of the App.\n"
                    "Customize your experience to help you track your loan expenses and calculate interest.\n"
                    "Analyze how the App is being used and improve its features.\n"
                    "Respond to your inquiries and customer support requests.\n\n"
                    "3. Data Storage and Security\n"
                    "We store the information you provide solely on your device, and it is not stored on our servers unless explicitly stated in certain scenarios (such as syncing user data with an account, if applicable).\n"
                    "We implement reasonable security measures to protect the information you provide. However, no data transmission over the internet can be guaranteed to be 100% secure, and we cannot ensure or warrant the security of your information.\n\n"
                    "4. Third-Party Services\n"
                    "We may use third-party services for analytics, crash reporting, and performance monitoring. These services may collect anonymous data about your usage of the App. Please refer to the privacy policies of these third-party services for more information.\n\n"
                    "5. Data Retention\n"
                    "We retain the data you provide within the App only for as long as necessary to provide our services to you. If you choose to delete your account or uninstall the App, we will remove all personal data stored within the App from your device.\n\n"
                    "6. Your Rights\n"
                    "You have the right to:\n"
                    "Access the information we hold about you and request correction of any inaccuracies.\n"
                    "Delete any personal data from the App by removing your account or uninstalling the App.\n"
                    "Opt-out of data collection features such as analytics if provided within the App settings.\n\n"
                    "7. Children’s Privacy\n"
                    "The App is not intended for children under the age of 13, and we do not knowingly collect any personal information from children. If we learn that we have collected personal information from a child under the age of 13, we will take steps to delete that information as soon as possible.\n\n"
                    "8. Changes to the Privacy Policy\n"
                    "We may update this Privacy Policy at any time. Any changes will be posted in the App or on our website, and the revised policy will become effective as soon as they are posted. Your continued use of the App after any changes to the Privacy Policy constitutes your acceptance of the new policy.",
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
