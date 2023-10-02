/*
*  Step-1  Create User Model
* */

import 'package:cloud_firestore/cloud_firestore.dart';

class LicensedCollectorModel {
  final String? id;
  final String username;
  final String email;
  final String county;
  final String subCountry;
  final String ward;
  final String license;
  final String phoneNumber;
  final String? supervisorIdentity;

  ///Model Constructor
  const LicensedCollectorModel({
    this.id,
    this.supervisorIdentity,
    required this.username,
    required this.email,
    required this.county,
    required this.subCountry,
    required this.ward,
    required this.license,
    required this.phoneNumber,
  });

  ///Convert Model to Firebase Json Format
  toJson() {
    return {
      "Username": username,
      "Email": email,
      "County": county,
      "SubCounty": subCountry,
      "Ward": ward,
      "Licensed": license,
      "PhoneNumber": phoneNumber,
      "SupervisorIdentity": supervisorIdentity,
    };
  }

  ///Step-1 Map user fetched from Firebase to UserModel
  factory LicensedCollectorModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
//print(data);
    return LicensedCollectorModel(
        id: document.id ?? '',
        supervisorIdentity: data['SupervisorIdentity'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        county: data['County'] ?? '',
        subCountry: data['SubCounty'] ?? '',
        ward: data['Ward'] ?? '',
        license: data['Licensed'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '');
  }
}
