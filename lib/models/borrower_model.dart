import 'package:wetrack/models/loan_model.dart';
class Borrower {
  String id;
  String name;
  String phone;
  String email;
  String loanPurpose;
  String paymentMethod;
  double loanAmount;
  double interest;
  List<Map<String, dynamic>> terms;
  List<Loan> loans;

  Borrower({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.loanPurpose,
    required this.paymentMethod,
    required this.loanAmount,
    required this.interest,
    required this.terms,
    required this.loans,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'loanPurpose': loanPurpose,
      'paymentMethod': paymentMethod,
      'loanAmount': loanAmount,
      'interest': interest,
      'terms': terms,
      'loans': loans.map((loan) => loan.toMap()).toList(),  // Convert each Loan object to Map
    };
  }

  // Convert Map to Borrower object
  factory Borrower.fromMap(Map<String, dynamic> map) {
    return Borrower(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      loanPurpose: map['loanPurpose'],
      paymentMethod: map['paymentMethod'],
      loanAmount: map['loanAmount'], 
      interest: map['interest'],
      terms: List<Map<String, dynamic>>.from(map['terms']),
      loans: List<Loan>.from(
        map['loans'].map((loanMap) => Loan.fromMap(loanMap))
      ),
    );
  }
}
