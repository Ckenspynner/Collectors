import 'package:collectors/main.dart';
import 'package:collectors/src/constants/image_strings.dart';
import 'package:collectors/src/features/authentication/controllers/signup_controller.dart';
import 'package:collectors/src/features/authentication/model/LicensedCollectorsModel.dart';
import 'package:collectors/src/features/authentication/screens/dashboard/dashboard_collector_2.dart';
import 'package:collectors/src/features/authentication/screens/dashboard/dashboard_mrf_3.dart';
import 'package:collectors/src/features/authentication/screens/dashboard/dashboard_register_collector_1.dart';
import 'package:collectors/src/repository/authentication_repository/authentication_repository.dart';
import 'package:collectors/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class RegisteredCollectors extends StatefulWidget {
  const RegisteredCollectors({Key? key}) : super(key: key);

  @override
  _RegisteredCollectorsState createState() => _RegisteredCollectorsState();
}

class _RegisteredCollectorsState extends State<RegisteredCollectors> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery
        .of(context)
        .size
        .width / baseWidth;
    double ffem = fem * 0.97;

    final controller = Get.put(AddRegisteredCollectorController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registered Collector",
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
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
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
                minHeight: MediaQuery
                    .of(context)
                    .size
                    .height,
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
                        controller: controller.controllerUsername,
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
                          hintText: 'Name',
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
                            return "Enter Name";
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
                            return "Enter County";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20 * fem,
                      ),
                      TextFormField(
                        controller: controller.controllerCounty,
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
                          hintText: 'County',
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
                            return "Enter County";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20 * fem,
                      ),
                      TextFormField(
                        controller: controller.controllerSubCountry,
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
                          hintText: 'Sub-Country',
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
                            return "Enter Sub-Country";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20 * fem,
                      ),
                      TextFormField(
                        controller: controller.controllerWard,
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
                          hintText: 'Ward',
                          hintStyle: const TextStyle(
                              fontSize: 17, color: Colors.white),
                          //label: const Text('Username',style: TextStyle(color: Colors.white),),
                          suffixIcon: const Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Ward";
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
                          hintText: 'License',
                          hintStyle: const TextStyle(
                              fontSize: 17, color: Colors.white),
                          //label: const Text('Username',style: TextStyle(color: Colors.white),),
                          suffixIcon: const Icon(
                            Icons.badge_outlined,
                            color: Colors.white,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter License";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20 * fem,
                      ),
                      TextFormField(
                        controller: controller.controllerPhoneNumber,
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
                            Icons.settings_phone,
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

                            //Store User Data
                            final licensedCollector = LicensedCollectorModel(
                                username: controller.controllerUsername.text.toTitleCase().trim(),
                                email: 'LA${controller.controllerEmail.text.trim()}'.toLowerCase(),
                                county: controller.controllerCounty.text.toTitleCase().trim(),
                                subCountry: controller.controllerSubCountry.text.toTitleCase().trim(),
                                ward: controller.controllerWard.text.toTitleCase().trim(),
                                license: 'LA${controller.controllerLicense.text.trim()}'.toUpperCase(),
                                phoneNumber: controller.controllerPhoneNumber.text.trim()
                            );

                            //Register and Authenticate Users
                            AddRegisteredCollectorController.instance.createLicensedCollector(licensedCollector);
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
