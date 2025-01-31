class Loan {
  final String loanId;
  final String loanProvider;
  final String loanPurpose;
  final String paymentMethod;
  final double loanAmount;
  final double interest;
  final bool isPaid;
  final DateTime createdAt;
  final List<Map<String, dynamic>> terms;
  final double amountPaid; 

  Loan({
    required this.loanId,
    required this.loanProvider,
    required this.loanPurpose,
    required this.paymentMethod,
    required this.loanAmount,
    required this.interest,
    required this.isPaid,
    required this.createdAt,
    required this.terms,
    required this.amountPaid, 
  });

  Map<String, dynamic> toMap() {
    return {
      'loanId': loanId,
      'loanProvider': loanProvider,
      'loanPurpose': loanPurpose,
      'paymentMethod': paymentMethod,
      'loanAmount': loanAmount,
      'interest': interest,
      'isPaid': isPaid,
      'createdAt': createdAt.toIso8601String(),
      'terms': terms,
      'amountPaid': amountPaid,  // Include it when serializing
    };
  }

  factory Loan.fromMap(Map<String, dynamic> map) {
    return Loan(
      loanId: map['loanId'],
      loanProvider: map['loanProvider'],
      loanPurpose: map['loanPurpose'],
      paymentMethod: map['paymentMethod'],
      loanAmount: map['loanAmount'],
      interest: map['interest'],
      isPaid: map['isPaid'],
      createdAt: DateTime.parse(map['createdAt']),
      terms: List<Map<String, dynamic>>.from(map['terms']),
      amountPaid: map['amountPaid'],
    );
  }
}
