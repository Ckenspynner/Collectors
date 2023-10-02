import 'package:collectors/main.dart';
import 'package:collectors/src/constants/image_strings.dart';
import 'package:collectors/src/features/authentication/controllers/signup_controller.dart';
import 'package:collectors/src/features/authentication/model/LicensedCollectorsModel.dart';
import 'package:collectors/src/features/authentication/model/TruckCollectorModel.dart';
import 'package:collectors/src/repository/authentication_repository/authentication_repository.dart';
import 'package:collectors/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

class TruckStationForm extends StatefulWidget {
  final String truckStation;

  const TruckStationForm({
    Key? key,
    required this.truckStation,
  }) : super(key: key);

  @override
  _TruckStationFormState createState() => _TruckStationFormState();
}

class _TruckStationFormState extends State<TruckStationForm> {
  final _formKey = GlobalKey<FormState>();

  Future<void> loader() async {
    OverlayLoadingProgress.start(context,
        gifOrImagePath: 'assets/loading.gif',
        barrierDismissible: true,
        widget: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Colors.black38,
          color: appDark,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: appGold,
                  size: 30,
                ),
              ),
            ],
          ),
        ));
    await Future.delayed(const Duration(seconds: 1));
    OverlayLoadingProgress.stop();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    final controller = Get.put(AddRegisteredCollectorController());
    final _authRepo = Get.put(AuthenticationRepository());
    final emailAccount = _authRepo.firebaseUser.value?.email;

    return Scaffold(
      appBar: AppBar(
        // leading: GestureDetector(
        //   child: Transform.scale(
        //     scale: 0.6,
        //     child: Image.asset(
        //       arrow_back,
        //     ),
        //   ),
        //   onTap: () => Get.to(() => const LicensedCollector()),
        // ),
        title: Text(
          widget.truckStation,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appGold,
        foregroundColor: appDark,
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            // rectangle949zZ (4:4863)
            left: 0 * fem,
            top: 0 * fem,
            child: Align(
              child: Container(
                width: 375 * fem,
                height: 800 * fem,
                color: appGold,
              ),
            ),
          ),
          Positioned(
            // rectangle682FGu (4:4864)
            left: 0 * fem,
            top: 0 * fem,
            child: Align(
              child: SizedBox(
                width: 375 * fem,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff1c162e),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24 * fem),
                      topRight: Radius.circular(24 * fem),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x4c000000),
                        offset: Offset(0 * fem, 0 * fem),
                        blurRadius: 10 * fem,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
                minWidth: double.infinity,
              ),
              child: Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        countyLogo,
                        width: 100 * fem,
                        height: 100 * fem,
                      ),
                      SizedBox(
                        height: 15 * fem,
                      ),
                      SizedBox(
                        height: 15 * fem,
                      ),
                      TextFormField(
                        controller: controller.controllerOparator,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          fillColor: const Color(0xff140f26),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11 * fem),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11 * fem),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          hintText: 'Username',
                          hintStyle: const TextStyle(
                              fontSize: 17, color: Colors.white),
                          //label: const Text('Username',style: TextStyle(color: Colors.white),),
                          suffixIcon: const Icon(
                            Icons.map,
                            color: Colors.white,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Username";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20 * fem,
                      ),
                      TextFormField(
                        controller: controller.controllerEmail,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          fillColor: const Color(0xff140f26),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11 * fem),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11 * fem),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                              fontSize: 17, color: Colors.white),
                          //label: const Text('Username',style: TextStyle(color: Colors.white),),
                          suffixIcon: const Icon(
                            Icons.map,
                            color: Colors.white,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Email";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20 * fem,
                      ),
                      TextFormField(
                        controller: controller.controllerLicense,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          fillColor: const Color(0xff140f26),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11 * fem),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11 * fem),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          hintText: 'License Number',
                          hintStyle: const TextStyle(
                              fontSize: 17, color: Colors.white),
                          //label: const Text('Username',style: TextStyle(color: Colors.white),),
                          suffixIcon: const Icon(
                            Icons.map,
                            color: Colors.white,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter License Number";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20 * fem,
                      ),
                      TextFormField(
                        controller: controller.controllerModel,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          fillColor: const Color(0xff140f26),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11 * fem),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11 * fem),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          hintText: widget.truckStation == 'Add Truck'
                              ? 'Model Number'
                              : 'Station Name',
                          hintStyle: const TextStyle(
                              fontSize: 17, color: Colors.white),
                          //label: const Text('Username',style: TextStyle(color: Colors.white),),
                          suffixIcon: const Icon(
                            Icons.person_outline_rounded,
                            color: Colors.white,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Model/station";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20 * fem,
                      ),
                      TextFormField(
                        controller: controller.controllerTagNumber,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          fillColor: const Color(0xff140f26),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11 * fem),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11 * fem),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          hintText: 'Tag Number',
                          hintStyle: const TextStyle(
                              fontSize: 17, color: Colors.white),
                          //label: const Text('Username',style: TextStyle(color: Colors.white),),
                          suffixIcon: const Icon(
                            Icons.map,
                            color: Colors.white,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Tag Number";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20 * fem,
                      ),
                      TextFormField(
                        controller: controller.controllerPhoneNumber,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          fillColor: const Color(0xff140f26),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11 * fem),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11 * fem),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          hintText: 'Phone Number',
                          hintStyle: const TextStyle(
                              fontSize: 17, color: Colors.white),
                          //label: const Text('Username',style: TextStyle(color: Colors.white),),
                          suffixIcon: const Icon(
                            Icons.map,
                            color: Colors.white,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Phone Number";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20 * fem,
                      ),
                      TextFormField(
                        controller: controller.controllerCapacity,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          fillColor: const Color(0xff140f26),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11 * fem),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11 * fem),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          hintText: widget.truckStation == 'Add Truck'
                              ? 'Tonnage Capacity'
                              : 'Size in (m/sq)',
                          hintStyle: const TextStyle(
                              fontSize: 17, color: Colors.white),
                          //label: const Text('Username',style: TextStyle(color: Colors.white),),
                          suffixIcon: const Icon(
                            Icons.share_location,
                            color: Colors.white,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Capacity";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20 * fem,
                      ),
                      SizedBox(
                        height: 20 * fem,
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 20 * fem),
                          padding: EdgeInsets.fromLTRB(
                              35 * fem, 18 * fem, 22 * fem, 18 * fem),
                          width: 150 * fem,
                          height: 56 * fem,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50 * fem),
                            color: appGold,
                          ),
                          child: Container(
                            // group12696JDf (I4:4883;10236:71734)
                            width: double.infinity,
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  // textrW5 (I4:4883;10236:71735)
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 28 * fem, 0 * fem),
                                    child: Text(
                                      'Submit',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont(
                                        'Inria Sans',
                                        fontSize: 14 * ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.4285714286 * ffem / fem,
                                        color: const Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  // component7iconsarrowleftLAM (I4:4883;10236:71736)
                                  width: 16 * fem,
                                  height: 16 * fem,
                                  child: Image.asset(
                                    login_arrow,
                                    width: 16 * fem,
                                    height: 16 * fem,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          //Adds this changes

                          if (_formKey.currentState!.validate()) {
                            //Step-3 Get Users and Pass it to Controller

                            switch (widget.truckStation) {
                              //Store User Data
                              case 'Add Truck':
                                final truckCollector = TruckCollectorModel(
                                  email:
                                      'DA${controller.controllerEmail.text.trim()}'
                                          .toLowerCase(),
                                  model: controller.controllerModel.text
                                      .toTitleCase()
                                      .trim(),
                                  tagname: controller.controllerTagNumber.text
                                      .toUpperCase()
                                      .trim(),
                                  oparator: controller.controllerOparator.text
                                      .toTitleCase()
                                      .trim(),
                                  oparatorNumber: controller
                                      .controllerPhoneNumber.text
                                      .trim(),
                                  capacity:
                                      '${controller.controllerCapacity.text.toTitleCase()} tonnes'
                                          .trim(),
                                  license:
                                      'DA${controller.controllerLicense.text.trim()}'
                                          .toUpperCase(),
                                  // supervisorIdentity: emailAccount?.trim(),
                                );

                                //Register and Authenticate Users
                                AddRegisteredCollectorController.instance
                                    .truckCollector(truckCollector);
                                Future.delayed(Duration.zero, () async {
                                  loader();
                                });
                              case 'Add Station':
                                final stationCollector = TruckCollectorModel(
                                  email:
                                      'SA${controller.controllerEmail.text.trim()}'
                                          .toLowerCase(),
                                  model: controller.controllerModel.text
                                      .toTitleCase()
                                      .trim(),
                                  tagname: controller.controllerTagNumber.text
                                      .toUpperCase()
                                      .trim(),
                                  oparator: controller.controllerOparator.text
                                      .toTitleCase()
                                      .trim(),
                                  oparatorNumber: controller
                                      .controllerPhoneNumber.text
                                      .trim(),
                                  capacity:
                                      '${controller.controllerCapacity.text.toTitleCase()} tonnes'
                                          .trim(),
                                  license:
                                      'SA${controller.controllerLicense.text.trim()}'
                                          .toUpperCase(),
                                  // supervisorIdentity: emailAccount?.trim(),
                                );

                                //Register and Authenticate Users
                                AddRegisteredCollectorController.instance
                                    .stationCollector(stationCollector);

                                Future.delayed(Duration.zero, () async {
                                  loader();
                                });
                              case 'Add PRO':
                              // final truckCollector = TruckCollectorModel(
                              //   email:
                              //   'SA${controller.controllerEmail.text.trim()}'
                              //       .toLowerCase(),
                              //   model: controller.controllerModel.text
                              //       .toTitleCase()
                              //       .trim(),
                              //   tagname: controller.controllerTagNumber.text
                              //       .toTitleCase()
                              //       .trim(),
                              //   oparator: controller.controllerOparator.text
                              //       .toTitleCase()
                              //       .trim(),
                              //   oparatorNumber: controller
                              //       .controllerPhoneNumber.text
                              //       .trim(),
                              //   capacity: controller.controllerWard.text
                              //       .toTitleCase()
                              //       .trim(),
                              //   license:
                              //   'SA${controller.controllerLicense.text.trim()}'
                              //       .toUpperCase(),
                              //   // supervisorIdentity: emailAccount?.trim(),
                              // );
                              //
                              // //Register and Authenticate Users
                              // AddRegisteredCollectorController.instance
                              //     .truckCollector(truckCollector);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
