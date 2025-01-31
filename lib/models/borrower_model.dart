import 'package:wetrack/models/loan_model.dart';  // Import Loan model

class Borrower {
  String id;
  String name;
  String phone;
  String email;
  List<Loan> loans;  // List of loans associated with this borrower

  Borrower({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.loans,  // List of loans for the borrower
  });

  // Convert Borrower to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'loans': loans.map((loan) => loan.toMap()).toList(),  // Convert loans to Map
    };
  }

  // Create Borrower from Firestore Map
  factory Borrower.fromMap(Map<String, dynamic> map) {
    return Borrower(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      loans: List<Loan>.from(
        map['loans'].map((loanMap) => Loan.fromMap(loanMap, map['id'])) // Pass the second argument (id)
      ),
    );
  }
}
