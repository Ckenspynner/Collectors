import 'package:collectors/src/features/authentication/model/LicensedCollectorsModel.dart';
import 'package:collectors/src/features/authentication/model/TruckCollectorModel.dart';
import 'package:collectors/src/repository/authentication_repository/authentication_repository.dart';
import 'package:collectors/src/repository/licensedcollectorAgents_repository/licensedcollectoragents_repository.dart';
import 'package:collectors/src/repository/licensedcollector_repository/licensedcollector_repository.dart';
import 'package:collectors/src/repository/truckcollector_repository/truckcollector_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TruckCollectorController extends GetxController{
  static TruckCollectorController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final truckCollectorRepo = Get.put(TruckCollectorRepository());

  /// Get Truck Collector Agent Dashboard Data
  getTruckCollectorData() {
    final email = _authRepo.firebaseUser.value?.email;
    if(email != null){
      return truckCollectorRepo.getTruckCollectorsData(email);
    }else{
      Get.snackbar("Error", "Login to continue");
    }
  }

  /// Get Station Collector Agent Dashboard Data
  getStationCollectorData() {
    final email = _authRepo.firebaseUser.value?.email;
    if(email != null){
      return truckCollectorRepo.getStationCollectorsData(email);
    }else{
      Get.snackbar("Error", "Login to continue");
    }
  }
}