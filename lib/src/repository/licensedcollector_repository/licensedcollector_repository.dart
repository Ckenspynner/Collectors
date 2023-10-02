import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collectors/main.dart';
import 'package:collectors/src/features/authentication/model/LicensedCollectorsModel.dart';
import 'package:collectors/src/features/authentication/model/dataScannerModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

/*
*  Step-2 Create User Repository to perform Databases Operation
* */


class LicensedCollectorRepository extends GetxController {
  static LicensedCollectorRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  ///Create LicensedCollector
  createLicensedCollector(LicensedCollectorModel licensedCollectorModel) async {
    await _db.collection("LicensedCollector")
        .add(licensedCollectorModel.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Account has been created.",
              snackPosition: SnackPosition.TOP,
              backgroundColor: appDark.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    });
  }

  ///Fetch LicensedCollector Dashboard Data
  Future<LicensedCollectorModel> getLicensedCollectorData(String email) async {
    final snapshot = await _db.collection("LicensedCollector").where("Email", isEqualTo: email).get();
    final licensedCollectorData = snapshot.docs.map((e) => LicensedCollectorModel.fromSnapshot(e)).single;
    return licensedCollectorData;
  }

  ///Fetch Licensed Collector Agent Dashboard Data
  Future<LicensedCollectorModel> getLicensedCollectorAgentData(String email) async {
    final snapshot = await _db.collection("LicensedCollectorAgents").where("Email", isEqualTo: email).get();
    final licensedCollectorData = snapshot.docs.map((e) => LicensedCollectorModel.fromSnapshot(e)).single;
    return licensedCollectorData;
  }

  ///Fetch ALL Licensed Collector Agents List
  Future<List<LicensedCollectorModel>> getLicensedCollectorDetails(String email) async {
    final snapshot = await _db.collection("LicensedCollectorAgents").where("SupervisorIdentity", isEqualTo: email).get();
    final licensedCollectorData = snapshot.docs.map((e) => LicensedCollectorModel.fromSnapshot(e)).toList();
    return licensedCollectorData;
  }

  ///Step-2 Fetch ALL LicensedCollector details
  Future<List<LicensedCollectorModel>> allLicensedCollectorDetails() async {
    final snapshot = await _db.collection("LicensedCollector").get();
    final licensedCollectorData = snapshot.docs.map((e) => LicensedCollectorModel.fromSnapshot(e)).toList();
    return licensedCollectorData;
  }

}
