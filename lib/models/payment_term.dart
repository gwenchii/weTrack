import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentTerm {
  String id;
  DateTime date;
  double amount;

  PaymentTerm({
    required this.id,
    required this.date,
    required this.amount,
  });

  // Convert a PaymentTerm object to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': Timestamp.fromDate(date), // Convert DateTime to Timestamp for Firestore
      'amount': amount,
    };
  }

  // Create a PaymentTerm object from a map
  factory PaymentTerm.fromMap(Map<String, dynamic> map) {
    return PaymentTerm(
      id: map['id'],
      date: (map['date'] as Timestamp).toDate(),
      amount: map['amount'],
    );
  }

  // Setter for the date
  set setDate(DateTime newDate) {
    date = newDate;
  }

  // Setter for the amount
  set setAmount(double newAmount) {
    amount = newAmount;
  }
}
