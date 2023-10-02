import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collectors/src/features/authentication/model/dataScannerModel.dart';
import 'package:collectors/src/repository/authentication_repository/authentication_repository.dart';
import 'package:collectors/src/repository/datascanner_repository/datascanner_repository.dart';
import 'package:collectors/src/repository/licensedcollector_repository/licensedcollector_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DataScannerController extends GetxController{
  static DataScannerController get instance => Get.find();

  ///Licensed Collector Repository
  final dataScannerRepo = Get.put(DataScannerRepository());

  final _authRepo = Get.put(AuthenticationRepository());
  final _licensedCollectorRepo = Get.put(LicensedCollectorRepository());
  final _dataScannerRepo = Get.put(DataScannerRepository());

  ///Adds a Scanner Data to Firestore
  Future<void> storeScannedData(DataScannerModel dataScannerModel) async {
    await dataScannerRepo.storeDataScanner(dataScannerModel);
  }

  ///Adds a Scanner Data to Firestore
  Future<void> storeDriverScannedData(DataScannerModel dataScannerModel) async {
    await dataScannerRepo.storeDriverDataScanner(dataScannerModel);
  }

  ///Adds a Scanner Data to Firestore
  Future<void> storeStationScannedData(DataScannerModel dataScannerModel) async {
    await dataScannerRepo.storeStationDataScanner(dataScannerModel);
  }

  /// Get Licensed Collector Agent Dashboard Data
  getLicensedCollectorAgentData9() {
    final email = _authRepo.firebaseUser.value?.email;
    if(email != null){
      return _dataScannerRepo .getLicensedCollectorAgentData9(email);
      //return _dataScannerRepo.allDataScannerDetails();
    }else{
      Get.snackbar("Error", "Login to continue");
    }
  }


}