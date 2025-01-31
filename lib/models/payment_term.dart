import 'package:cloud_firestore/cloud_firestore.dart';
class PaymentTerm {
  String id;
  DateTime date;  // Date of the payment
  double amount;  // Payment amount
  bool isPaid;  // Track whether the payment has been made

  PaymentTerm({
    required this.id,
    required this.date,
    required this.amount,
    this.isPaid = false,  // Default to false if not provided
  });

  // Convert PaymentTerm to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': Timestamp.fromDate(date),  // Convert DateTime to Timestamp for Firestore
      'amount': amount,
      'isPaid': isPaid,  // Store payment status
    };
  }

  factory PaymentTerm.fromMap(Map<String, dynamic> map) {
    return PaymentTerm(
      id: map['id'],
      date: (map['date'] as Timestamp).toDate(),  // Convert Firestore Timestamp to DateTime
      amount: map['amount'],
      isPaid: map['isPaid'] ?? false,  // Default to false if isPaid is not present
    );
  }


  String get paymentStatus => isPaid ? "Completed" : "Pending";


  @override
  String toString() {
    return 'PaymentTerm(id: $id, date: $date, amount: Php $amount, isPaid: $paymentStatus)';
  }
}
