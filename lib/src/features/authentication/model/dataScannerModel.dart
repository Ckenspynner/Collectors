/*
*  Step-1  Create the Model
* */

import 'package:cloud_firestore/cloud_firestore.dart';

class DataScannerModel {
  final String? id;
  final String enumerator;
  final String sourceName;
  final String? segregation;
  final String currentDate;
  final String wet;
  final String dry;
  final String? enumeratorEmail;
  final String? supervisorIdentity;

  ///Model Constructor
  const DataScannerModel(
      {this.id,
        required this.currentDate,
      required this.enumerator,
      required this.sourceName,
      this.segregation,
      required this.wet,
      required this.dry,
        this.enumeratorEmail,
      this.supervisorIdentity,});

  ///Convert Model to Firebase Json Format
  toJson() {
    return {
      "Enumerator": enumerator,
      "SourceName": sourceName,
      "Segregation": segregation,
      "Wet": wet,
      "Dry": dry,
      "CurrentDate": currentDate,
      "EnumeratorEmail": enumeratorEmail,
      "SupervisorIdentity": supervisorIdentity,
    };
  }

  ///Step-1 Map user fetched from Firebase to UserModel
  factory DataScannerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
//print(data);
    return DataScannerModel(
      id: document.id ?? '',
      supervisorIdentity: data['SupervisorIdentity'] ?? '',
      sourceName: data['sourceName'] ?? '',
      segregation: data['Segregation'] ?? '',
      wet: data['Wet'] ?? '',
      dry: data['Dry'] ?? '',
      currentDate: data['CurrentDate'] ?? '',
      enumerator: data['Enumerator'] ?? '',
      enumeratorEmail: data['EnumeratorEmail'] ?? '',
    );
  }
}
