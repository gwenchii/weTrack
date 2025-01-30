class Loan {
  String id;
  String borrowerId;
  String loanPurpose;
  String paymentMethod;
  double loanAmount;
  double interest;
  List<Map<String, dynamic>> paymentTerms;  // Ensure this field exists

  // Constructor with named parameters, including paymentTerms
  Loan({
    required this.id,
    required this.borrowerId,
    required this.loanPurpose,
    required this.paymentMethod,
    required this.loanAmount,
    required this.interest,
    required this.paymentTerms,  // Add this line to pass paymentTerms
  });

  // Convert Loan to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'borrowerId': borrowerId,
      'loanPurpose': loanPurpose,
      'paymentMethod': paymentMethod,
      'loanAmount': loanAmount,
      'interest': interest,
      'paymentTerms': paymentTerms,
    };
  }

  // Create Loan from Firestore Map
  factory Loan.fromMap(Map<String, dynamic> map) {
    return Loan(
      id: map['id'],
      borrowerId: map['borrowerId'],
      loanPurpose: map['loanPurpose'],
      paymentMethod: map['paymentMethod'],
      loanAmount: map['loanAmount'],
      interest: map['interest'],
      paymentTerms: List<Map<String, dynamic>>.from(map['paymentTerms']),
    );
  }
}
