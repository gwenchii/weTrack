import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore to handle Timestamp

class Loan {
  final String loanProvider;
  final String loanPurpose;
  final String paymentMethod;
  final double loanAmount;
  final double interest;
  final List<Map<String, dynamic>> terms;
  final DateTime createdAt;

  Loan({
    required this.loanProvider,
    required this.loanPurpose,
    required this.paymentMethod,
    required this.loanAmount,
    required this.interest,
    required this.terms,
    required this.createdAt,
  });

  // Factory method to create a Loan object from a Map
  factory Loan.fromMap(Map<String, dynamic> map) {
    return Loan(
      loanProvider: map['loanProvider'],
      loanPurpose: map['loanPurpose'],
      paymentMethod: map['paymentMethod'],
      loanAmount: map['loanAmount'],
      interest: map['interest'],
      terms: List<Map<String, dynamic>>.from(map['terms']),
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate() // Convert Firestore Timestamp to DateTime
          : DateTime.now(), // Fallback in case it's not a Timestamp
    );
  }

  // Method to convert Loan object to a Map (for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'loanProvider': loanProvider,
      'loanPurpose': loanPurpose,
      'paymentMethod': paymentMethod,
      'loanAmount': loanAmount,
      'interest': interest,
      'terms': terms,
      'createdAt': Timestamp.fromDate(createdAt), // Convert DateTime to Firestore Timestamp
    };
  }

  // Optionally, you can set the ID if you need it for document references
  String? get id => null; // Or assign a document ID if needed
}
