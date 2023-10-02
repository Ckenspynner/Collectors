import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collectors/src/features/authentication/model/LicensedCollectorsModel.dart';
import 'package:collectors/src/features/authentication/model/TruckCollectorModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

/*
*  Step-2 Create User Repository to perform Databases Operation
* */


class TruckCollectorRepository extends GetxController {
  static TruckCollectorRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  ///Create Truck Collector
  createTruckCollector(TruckCollectorModel truckCollectorModel) async {
    await _db.collection("TruckCollector")
        .add(truckCollectorModel.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Account has been created.",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    });
  }

  ///Create Station Collector Agents
  createStationCollector(TruckCollectorModel truckCollectorModel) async {
    await _db.collection("StationCollector")
        .add(truckCollectorModel.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Account has been created.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green),
    )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    });
  }

  ///Fetch Truck Collector Agent Dashboard Data
  Future<TruckCollectorModel> getTruckCollectorsData(String email) async {
    final snapshot = await _db.collection("TruckCollector").where("Email", isEqualTo: email).get();
    final truckCollectorData = snapshot.docs.map((e) => TruckCollectorModel.fromSnapshot(e)).single;
    return truckCollectorData;
  }

  ///Fetch Truck Collector Agent Dashboard Data
  Future<TruckCollectorModel> getStationCollectorsData(String email) async {
    final snapshot = await _db.collection("StationCollector").where("Email", isEqualTo: email).get();
    final truckCollectorData = snapshot.docs.map((e) => TruckCollectorModel.fromSnapshot(e)).single;
    return truckCollectorData;
  }

}
