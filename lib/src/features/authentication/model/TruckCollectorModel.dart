/*
*  Step-1  Create User Model
* */

import 'package:cloud_firestore/cloud_firestore.dart';

class TruckCollectorModel {
  final String? id;
  final String oparator;
  final String email;
  final String model;
  final String tagname;
  final String oparatorNumber;
  final String capacity;
  final String license;

  ///Model Constructor
  const TruckCollectorModel({
    this.id,
    required this.oparator,
    required this.email,
    required this.model,
    required this.tagname,
    required this.capacity,
    required this.license,
    required this.oparatorNumber,
  });

  ///Convert Model to Firebase Json Format
  toJson() {
    return {
      "Oparator": oparator,
      "Email": email,
      "Model": model,
      "Tagname": tagname,
      "OparatorNumber": oparatorNumber,
      "Capacity": capacity,
      "License": license,
    };
  }

  ///Step-1 Map user fetched from Firebase to UserModel
  factory TruckCollectorModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
//print(data);
    return TruckCollectorModel(
        id: document.id ?? '',
        oparator: data['Oparator'] ?? '',
        email: data['Email'] ?? '',
        model: data['Model'] ?? '',
        tagname: data['Tagname'] ?? '',
        oparatorNumber: data['OparatorNumber'] ?? '',
        capacity: data['Capacity'] ?? '',
        license: data['License'] ?? '');
  }
}
