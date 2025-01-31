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
  List<Map<String, dynamic>> terms; // List of terms with proof and payment status

  Loan({
    required this.loanId, // 'id' is required
    required this.loanProvider,
    required this.loanPurpose,
    required this.paymentMethod,
    required this.loanAmount,
    required this.interest,
    required this.isPaid, // 'isPaid' is required
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

  // Update a term with proof of payment and mark it as paid
  void addProofOfPayment(int index, String proofFileName) {
    terms[index]["paid"] = true;
    terms[index]["proofFile"] = proofFileName; // Store proof file name
  }
}
