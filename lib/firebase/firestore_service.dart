import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:wetrack/models/loan_model.dart';
import 'package:wetrack/models/borrower_model.dart';
import 'package:wetrack/models/payment_term.dart';
class FirestoreService {
  // ignore: unused_field
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final Logger _logger = Logger(); // Initialize the logger

  // Collection references
  final CollectionReference borrowersCollection =
      FirebaseFirestore.instance.collection('borrowers');
  final CollectionReference loansCollection =
      FirebaseFirestore.instance.collection('loans');

  // Create Borrower in Firestore
  Future<void> createBorrower(Borrower borrower) async {
    try {
      await borrowersCollection.doc(borrower.id).set(borrower.toMap());
      _logger.i("Borrower added successfully with ID: ${borrower.id}");
    } catch (e) {
      _logger.e("Error adding borrower: $e");
    }
  }

  // Get Borrower by ID from Firestore
  Future<Borrower?> getBorrower(String borrowerId) async {
    try {
      DocumentSnapshot doc = await borrowersCollection.doc(borrowerId).get();
      if (doc.exists) {
        _logger.i("Fetched borrower with ID: $borrowerId");
        return Borrower.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        _logger.w("No borrower found with ID: $borrowerId");
        return null;
      }
    } catch (e) {
      _logger.e("Error fetching borrower with ID $borrowerId: $e");
      return null;
    }
  }

  // Create Loan in Firestore
  Future<void> createLoan(Loan loan) async {
    try {
      await loansCollection.doc(loan.id).set(loan.toMap());
      _logger.i("Loan added successfully with ID: ${loan.id}");
    } catch (e) {
      _logger.e("Error adding loan: $e");
    }
  }

  // Get Loan by ID from Firestore
  Future<Loan?> getLoan(String loanId) async {
    try {
      DocumentSnapshot doc = await loansCollection.doc(loanId).get();
      if (doc.exists) {
        _logger.i("Fetched loan with ID: $loanId");
        return Loan.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        _logger.w("No loan found with ID: $loanId");
        return null;
      }
    } catch (e) {
      _logger.e("Error fetching loan with ID $loanId: $e");
      return null;
    }
  }

  // Add a new PaymentTerm for a Borrower
  Future<void> addPaymentTermToBorrower(
      String borrowerId, PaymentTerm paymentTerm) async {
    try {
      DocumentReference borrowerRef =
          borrowersCollection.doc(borrowerId);
      borrowerRef.update({
        'paymentTerms': FieldValue.arrayUnion([paymentTerm.toMap()])
      });
      _logger.i("Payment term added to borrower with ID: $borrowerId");
    } catch (e) {
      _logger.e("Error adding payment term to borrower: $e");
    }
  }

  // Add a new PaymentTerm to a Loan
  Future<void> addPaymentTermToLoan(String loanId, PaymentTerm paymentTerm) async {
    try {
      DocumentReference loanRef = loansCollection.doc(loanId);
      loanRef.update({
        'paymentTerms': FieldValue.arrayUnion([paymentTerm.toMap()])
      });
      _logger.i("Payment term added to loan with ID: $loanId");
    } catch (e) {
      _logger.e("Error adding payment term to loan: $e");
    }
  }
}
