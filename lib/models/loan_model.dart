import 'package:cloud_firestore/cloud_firestore.dart';

class Loan {
  String loanId;
  String loanProvider;
  String loanPurpose;
  String paymentMethod;
  double loanAmount;
  double interest;
  bool isPaid;
  DateTime createdAt;
  List<Map<String, dynamic>> terms;

  Loan({
    required this.loanId,  // 'id' is required
    required this.loanProvider,
    required this.loanPurpose,
    required this.paymentMethod,
    required this.loanAmount,
    required this.interest,
    required this.isPaid,  // 'isPaid' is required
    required this.createdAt,
    required this.terms,
  });

  // Convert Loan to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'loanId': loanId,
      'loanProvider': loanProvider,
      'loanPurpose': loanPurpose,
      'paymentMethod': paymentMethod,
      'loanAmount': loanAmount,
      'interest': interest,
      'isPaid': isPaid,
      'createdAt': createdAt,
      'terms': terms,
    };
  }

  // Create Loan from Firestore Map
  factory Loan.fromMap(Map<String, dynamic> map, String loanId) {
    return Loan(
      loanId: loanId,
      loanProvider: map['loanProvider'],
      loanPurpose: map['loanPurpose'],
      paymentMethod: map['paymentMethod'],
      loanAmount: map['loanAmount'],
      interest: map['interest'],
      isPaid: map['isPaid'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      terms: List<Map<String, dynamic>>.from(map['terms']),
    );
  }
}
