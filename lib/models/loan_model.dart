import 'package:wetrack/models/payment_term.dart';  // Import PaymentTerm model

class Loan {
  String id;
  String borrowerId;  // Reference to the borrower
  String loanPurpose;
  String paymentMethod;
  double loanAmount;
  double interest;
  List<PaymentTerm> paymentTerms;  // List of payment terms

  Loan({
    required this.id,
    required this.borrowerId,  // Borrower's ID
    required this.loanPurpose,
    required this.paymentMethod,
    required this.loanAmount,
    required this.interest,
    required this.paymentTerms,  // List of payment terms
  });

  // Convert Loan to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'borrowerId': borrowerId,  // Store the borrower's ID
      'loanPurpose': loanPurpose,
      'paymentMethod': paymentMethod,
      'loanAmount': loanAmount,
      'interest': interest,
      'paymentTerms': paymentTerms.map((term) => term.toMap()).toList(),  // Convert payment terms to Map
    };
  }

  // Create Loan from Firestore Map
  factory Loan.fromMap(Map<String, dynamic> map) {
    return Loan(
      id: map['id'],
      borrowerId: map['borrowerId'],  // Get borrower ID from Firestore data
      loanPurpose: map['loanPurpose'],
      paymentMethod: map['paymentMethod'],
      loanAmount: map['loanAmount'],
      interest: map['interest'],
      paymentTerms: List<PaymentTerm>.from(
        map['paymentTerms'].map((term) => PaymentTerm.fromMap(term))
      ),
    );
  }
}
