import 'payment_term.dart';  // Make sure PaymentTerm is imported

class Borrower {
  String id;
  String name;
  String phone;
  String email;
  List<PaymentTerm> paymentTerms;  // List of payment terms for the borrower

  Borrower({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.paymentTerms,  // List of payment terms
  });

  // Convert Borrower to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'paymentTerms': paymentTerms.map((term) => term.toMap()).toList(),  // Convert to Map
    };
  }

  // Create Borrower from Firestore Map
  factory Borrower.fromMap(Map<String, dynamic> map) {
    return Borrower(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      paymentTerms: List<PaymentTerm>.from(
        map['paymentTerms'].map((term) => PaymentTerm.fromMap(term))
      ),
    );
  }
}
