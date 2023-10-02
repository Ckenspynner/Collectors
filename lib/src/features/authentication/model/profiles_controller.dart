import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collectors/src/features/authentication/model/LicensedCollectorsModel.dart';
import 'package:collectors/src/repository/authentication_repository/authentication_repository.dart';
import 'package:collectors/src/repository/datascanner_repository/datascanner_repository.dart';
import 'package:collectors/src/repository/licensedcollector_repository/licensedcollector_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

/*
*  Step-2 Create User Repository to perform Databases Operation       xxx
* */


class ProfilesController extends GetxController {
  static ProfilesController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _licensedCollectorRepo = Get.put(LicensedCollectorRepository());

  ///Step-3 Get User Email and pass to UserRepository to fetch user record

  /// Get Licensed Collector Data
  Future<List<LicensedCollectorModel>> getAllLicensedCollectorAgentsData() async {
    final email = _authRepo.firebaseUser.value?.email;
    final snapshot = await _licensedCollectorRepo.getLicensedCollectorDetails(email!);
    return await _licensedCollectorRepo.getLicensedCollectorDetails(email);
  }

  /// Get Licensed Collector Dashboard Data
  getLicensedCollectorData(){
    final email = _authRepo.firebaseUser.value?.email;
    if(email != null){
      return _licensedCollectorRepo.getLicensedCollectorData(email);
    }else{
      Get.snackbar("Error", "Login to continue");
    }
  }

  /// Get Collected Data By Agents
  // Future<List<Map<String, dynamic>>> getScannedCollectedData() async {
  //   // Get docs from collection reference
  //   CollectionReference collectionRef =
  //   FirebaseFirestore.instance.collection('AgentScannerCollections');
  //
  //   QuerySnapshot querySnapshot = await collectionRef.get();
  //
  //   // Get data from docs and convert map to List
  //   final _allUsers_result =
  //   querySnapshot.docs.map((doc) => doc.data()).toList();
  //
  //   var _allUsers =
  //         (_allUsers_result).map((e) => e as Map<String, dynamic>)!.toList();
  //
  //   //print(_allUsers);
  //   return _allUsers;
  // }

  /// Get All Licensed Collector Data
  Future<List<LicensedCollectorModel>> getAllLicensedCollectorData() async {
    final snapshot = await _licensedCollectorRepo.allLicensedCollectorDetails();
    return await _licensedCollectorRepo.allLicensedCollectorDetails();
  }

  /// Get Licensed Collector Agent Dashboard Data
  getLicensedCollectorAgentData() {
    final email = _authRepo.firebaseUser.value?.email;
    if(email != null){
      return _licensedCollectorRepo.getLicensedCollectorAgentData(email);
      //return _dataScannerRepo.allDataScannerDetails();
    }else{
      Get.snackbar("Error", "Login to continue");
    }
  }




}
