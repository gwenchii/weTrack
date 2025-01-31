// ignore_for_file: unused_import, constant_identifier_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//auth
import 'package:wetrack/screens/auth/change_password.dart';
import 'package:wetrack/screens/auth/login_page.dart';
import 'package:wetrack/screens/auth/signup_page.dart';
import 'package:wetrack/screens/auth/forgot_password.dart';

//calculator
import 'package:wetrack/screens/calculator/compound_interest.dart';
import 'package:wetrack/screens/calculator/simple_interest.dart';
import 'package:wetrack/screens/calculator/terms.dart';
import 'package:wetrack/screens/calculator/rates.dart';
//home
import 'package:wetrack/screens/home/dashboard_page.dart';
import 'package:wetrack/screens/home/home_page.dart';
//loan
import 'package:wetrack/screens/loan/createborrower_page.dart';
import 'package:wetrack/screens/loan/createloan_page.dart';
import 'package:wetrack/screens/loan/scanqr_page.dart';
import 'package:wetrack/screens/loan/Profiles/borrower_profile.dart';
import 'package:wetrack/screens/loan/loan_profile.dart';
//profile
import 'package:wetrack/screens/profile/contact_us.dart';
import 'package:wetrack/screens/profile/notification_page.dart';
import 'package:wetrack/screens/profile/privacy_policy.dart';
import 'package:wetrack/screens/profile/terms_condition.dart';
import 'package:wetrack/screens/profile/userprofile_page.dart';
//splash
import 'package:wetrack/screens/splash/splash_screen.dart';
//widget
import 'package:wetrack/widgets/navigation_bar.dart';
//models
import 'package:wetrack/models/loan_model.dart';
import 'package:wetrack/models/borrower_model.dart';
import 'package:wetrack/models/notification_model.dart';
import 'package:wetrack/models/payment_term.dart';

class AppRoutes {
  // defining constant route names for easy declaration
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String changePass = '/change-password';
  static const String resetPass = '/reset-password';
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String simpleInterest = '/calculator/simple-interest';
  static const String compoundInterest = '/calculator/compound-interest';
  static const String paymentTerms = '/calculator/payment-terms';
  static const String rates = '/calculator/rates';
  static const String createLoan = '/create-loan';
  static const String borrowerProfile = '/borrower-profile';
  static const String loanProfile = '/loan-profile';
  static const String createBorrower = '/create-borrower';
  static const String qrScan = '/qr-scan';
  static const String profile = '/profile';
  static const String notifications = '/notifications';
  static const String termsAndConditions = '/terms-and-conditions';
  static const String privacyPolicy = '/privacy-policy';
  static const String contactUs = '/contact-us';

  // Route generator for dynamic navigation
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupPage());
      case changePass:
        return MaterialPageRoute(
            builder: (_) => ChangePasswordPage(auth: FirebaseAuth.instance));
      case resetPass:
        return MaterialPageRoute(builder: (_) => const ResetPassword());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case simpleInterest:
        return MaterialPageRoute(builder: (_) => const SimpleInterestPage());
      case compoundInterest:
        return MaterialPageRoute(builder: (_) => const CompoundInterestPage());
      case rates:
        return MaterialPageRoute(builder: (_) => const Rates());
      case paymentTerms:
        return MaterialPageRoute(
            builder: (_) => const TermsAndConditionsPage());
      case createLoan:
        return MaterialPageRoute(builder: (_) => const CreateLoanPage());
      case createBorrower:
        return MaterialPageRoute(builder: (_) => const CreateBorrowerPage());

      case borrowerProfile:
        final borrower = settings.arguments as Borrower?;
        if (borrower == null) {
          return _errorRoute('Missing borrower data');
        }
        return MaterialPageRoute(
          builder: (_) => BorrowerProfilePage(borrower: borrower),
        );

      case loanProfile:
        final loan = settings.arguments as Loan?;
        if (loan == null) {
          return _errorRoute('Missing loan data');
        }
        return MaterialPageRoute(
          builder: (_) => LoanProfilePage(loan: loan),
        );

      case qrScan:
        return MaterialPageRoute(builder: (_) => const QRScanPage());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationPage());
      case termsAndConditions:
        return MaterialPageRoute(
            builder: (_) => const TermsAndConditionsPage());
      case privacyPolicy:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyPage());
      case contactUs:
        return MaterialPageRoute(builder: (_) => const ContactUsPage());

      default:
        return _errorRoute('No route defined for ${settings.name}');
    }
  }

// Helper function for error routes
  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('Error: $message')),
      ),
    );
  }
}
