import 'package:wetrack/models/loan_model.dart';
class Borrower {
  String id;
  String name;
  String phone;
  String email;
  List<Loan> loans;

  Borrower({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.loans,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'loans': loans.map((loan) => loan.toMap()).toList(),
    };
  }


  factory Borrower.fromMap(Map<String, dynamic> map) {
    return Borrower(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      loans: List<Loan>.from(
        map['loans'].map((loanMap) => Loan.fromMap(loanMap, map['id'])))
    );
  }
}
