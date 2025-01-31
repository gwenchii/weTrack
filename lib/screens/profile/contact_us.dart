import 'package:flutter/material.dart';
import 'package:wetrack/screens/calculator/simple_interest.dart';
import 'package:wetrack/screens/home/home_page.dart';
import 'package:wetrack/screens/profile/settings.dart';
import 'package:wetrack/widgets/navigation_bar.dart';
import 'package:wetrack/screens/home/dashboard_page.dart'; // Import Dashboard
import 'package:wetrack/screens/loan/createborrower_page.dart'; // Import Create Borrower
// Import Calculator

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
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
          MaterialPageRoute(builder: (context) => const SimpleInterestPage()),
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
          'Contact Us',
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
            // Contact Us Box
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F0F0),
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
                    "If you have any questions or concerns about the Terms and Conditions, Privacy Policy, or our Data Practices, please feel free to reach out to us at:\n\n"
                    "Email: wetrackapp@gmail.com\n"
                    "Website: wetrack.com\n\n"
                    "We value your feedback and are here to assist you with any inquiries or support needs you may have.\n\n"
                    "You can also reach us through the following channels:\n\n"
                    "Phone: +63 (9999) 123-4565\n"
                    "Customer Support: support@wetrack.com\n"
                    "Business Inquiries: business@wetrack.com\n\n"
                    "Follow us on our social media channels for updates:\n"
                    "Facebook: facebook.com/wetrackapp\n"
                    "Twitter: twitter.com/wetrackapp\n"
                    "Instagram: instagram.com/wetrackapp\n\n"
                    "Our office hours are Monday to Friday, 9:00 AM to 6:00 PM (EST). We strive to respond to all inquiries within 24 hours.\n\n"
                    "\n\nWe look forward to hearing from you!\n",

                    style: TextStyle(
                      fontSize: 12,
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
