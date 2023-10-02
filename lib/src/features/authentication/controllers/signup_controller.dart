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

class AddRegisteredCollectorController extends GetxController{
  static AddRegisteredCollectorController get instance => Get.find();
  final controllerUsername = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerCounty = TextEditingController();
  final controllerSubCountry = TextEditingController();
  final controllerWard = TextEditingController();
  final controllerLicense = TextEditingController();
  final controllerPhoneNumber = TextEditingController();
  final controllerModel = TextEditingController();
  final controllerTagNumber = TextEditingController();
  final controllerOparator = TextEditingController();
  final controllerCapacity = TextEditingController();

  ///Licensed Collector Repository
  final licensedCollectorRepo = Get.put(LicensedCollectorRepository());
  final truckCollectorRepo = Get.put(TruckCollectorRepository());
  final licensedCollectorAgentsRepo = Get.put(LicensedCollectorAgentsRepository());

  ///Add Licensed Collector to Authenticate
  void registerUser(String email, String license) {
    AuthenticationRepository.instance.creatUserWithEmailAndPassword(email, license);
    // String? error = AuthenticationRepository.instance.creatUserWithEmailAndPassword(email, license) as String?;
    // if (error != null) {
    //   Get.showSnackbar(GetSnackBar(message: error.toString(),));
    // }
  }

  ///Adds a Licensed Collector to Firestore
  Future<void> createLicensedCollector(LicensedCollectorModel licensedCollectorModel) async {
    await licensedCollectorRepo.createLicensedCollector(licensedCollectorModel);
    registerUser(licensedCollectorModel.email, licensedCollectorModel.license);
    //Get.to(() => const OTPScreen());
  }

  ///Adds a Licensed Collector Agents to Firestore
  Future<void> createLicensedCollectorAgents(LicensedCollectorModel licensedCollectorModel) async {
    await licensedCollectorAgentsRepo.createLicensedCollectorAgents(licensedCollectorModel);
    registerUser(licensedCollectorModel.email, licensedCollectorModel.license);
    //Get.to(() => const OTPScreen());
  }

  ///Adds a Truck Collector to Firestore
  Future<void> truckCollector(TruckCollectorModel truckCollectorModel) async {
    await truckCollectorRepo.createTruckCollector(truckCollectorModel);
    registerUser(truckCollectorModel.email, truckCollectorModel.license);
    //Get.to(() => const OTPScreen());
  }

  ///Adds a Station Collector to Firestore
  Future<void> stationCollector(TruckCollectorModel truckCollectorModel) async {
    await truckCollectorRepo.createStationCollector(truckCollectorModel);
    registerUser(truckCollectorModel.email, truckCollectorModel.license);
    //Get.to(() => const OTPScreen());
  }

  ///Logins users
  void loginUser(String email, String password) {
    AuthenticationRepository.instance.loginWithEmailAndPassword(email, password);
  }

}