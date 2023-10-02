import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collectors/src/features/authentication/model/LicensedCollectorsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

/*
*  Step-2 Create User Repository to perform Databases Operation
* */


class LicensedCollectorAgentsRepository extends GetxController {
  static LicensedCollectorAgentsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  ///Create Licensed Collector Agents
  createLicensedCollectorAgents(LicensedCollectorModel licensedCollectorAgentsModel) async {
    await _db.collection("LicensedCollectorAgents")
        .add(licensedCollectorAgentsModel.toJson())
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
}
