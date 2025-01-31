class UserInfoModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;

  UserInfoModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
  });

  // Convert model to JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  // Convert JSON from Firebase to UserInfoModel
  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      uid: json['uid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
    );
  }
}
