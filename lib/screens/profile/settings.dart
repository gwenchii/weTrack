import 'package:flutter/material.dart';
import 'package:wetrack/screens/calculator/simple_interest.dart';
import 'package:wetrack/screens/home/home_page.dart';
import 'package:wetrack/screens/loan/createborrower_page.dart';
import 'package:wetrack/screens/home/dashboard_page.dart';
import 'package:wetrack/screens/profile/terms_condition.dart';
import 'package:wetrack/screens/profile/userprofile_page.dart';
import 'package:wetrack/screens/profile/notification_page.dart';
import 'package:wetrack/screens/profile/privacy_policy.dart';
// Terms and Conditions Page
import 'package:wetrack/screens/profile/contact_us.dart';
import 'package:wetrack/widgets/navigation_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedIndex = 4; // Settings Page is selected, assuming there are 6 items.

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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80), // Adjust the height as needed
          child: AppBar(
            automaticallyImplyLeading: false,
            title: const Padding(
              padding: EdgeInsets.only(top: 25.0), // Add top padding of 10px
              child: Text(
                'Settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25, // Adjust font size as needed
                ),
              ),
            ),
          ),
        ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20.0, 79.0, 20.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container with various settings options
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(246, 240, 240, 1),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Profile
                  ListTile(
                    title: const Text('Profile', style: TextStyle(fontSize: 16)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfilePage()),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Notifications', style: TextStyle(fontSize: 16)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NotificationPage()),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Terms and Conditions', style: TextStyle(fontSize: 16)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TermnsandCondition()),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Privacy and Policy', style: TextStyle(fontSize: 16)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Contact Us', style: TextStyle(fontSize: 16)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ContactUsPage()),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Log Out', style: TextStyle(fontSize: 16, color: Colors.red)),
                    onTap: () {
                    },
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
