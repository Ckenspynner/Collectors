import 'package:collectors/main.dart';
import 'package:collectors/src/constants/image_strings.dart';
import 'package:collectors/src/features/authentication/controllers/signup_controller.dart';
import 'package:collectors/src/features/authentication/screens/dashboard/dashboard_collector_2.dart';
import 'package:collectors/src/features/authentication/screens/dashboard/dashboard_driver_4.dart';
import 'package:collectors/src/features/authentication/screens/dashboard/dashboard_mrf_3.dart';
import 'package:collectors/src/features/authentication/screens/dashboard/dashboard_register_collector_1.dart';
import 'package:collectors/src/features/authentication/screens/dashboard/dashboard_station_5.dart';
import 'package:collectors/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  bool _toggleVisible = false;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    final controller = Get.put(AddRegisteredCollectorController());
    
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: appWhite,
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
              top: 44 * fem,
              child: Align(
                child: SizedBox(
                  width: 375 * fem,
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                    decoration: BoxDecoration(
                      color: appWhite,//.withOpacity(0.7),//Color(0xff1c162e),
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
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2,
                    left: 30 * fem,
                    right: 30 * fem,
                  ),
                  height: MediaQuery.of(context).size.height,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          countyLogo,
                          width: 100 * fem,
                          height: 100 * fem,
                        ),
                        SizedBox(
                          height: 15 * fem,
                        ),
                        Visibility(
                          visible: _toggleVisible,
                          child: const Text(
                            'Invalid Credentials',
                            style: TextStyle(color: Colors.redAccent),
                          ),
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
                            hintText: 'Username',
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
                              return "Enter Username";
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
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                                fontSize: 17, color: Colors.white),
                            //label: const Text('Username',style: TextStyle(color: Colors.white),),
                            suffixIcon: const Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            }
                          },
                        ),
                        SizedBox(
                          height: 50 * fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 12),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'forgot password?',
                                  style: TextStyle(color: appGold),
                                ),
                              ),
                            ],
                          ),
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
                            width: 136 * fem,
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
                                        'Login',
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
                            // if (_formKey.currentState!.validate()) {
                            //   String Account = controller.controllerLicense.text.toUpperCase().trim().substring(0,2);
                            //   AddRegisteredCollectorController.instance.loginUser(
                            //       '$Account${controller.controllerUsername.text.trim()}',
                            //       controller.controllerLicense.text.toUpperCase().trim());
                            // }
                            if (_formKey.currentState!.validate()) {
                              //print(controller.controllerLicense.text.toUpperCase().substring(0,2));
                              switch (controller.controllerLicense.text.toUpperCase().substring(0,2)) {
                                case 'RL':
                                  setState(() {
                                    _toggleVisible = false;
                                  });

                                  //Adds this changes
                                  // if (_formKey.currentState!.validate()) {
                                  //   AddRegisteredCollectorController.instance.loginUser(
                                  //       controller.controllerUsername.text.trim(),
                                  //       controller.controllerLicense.text.toUpperCase().trim());
                                  // }

                                  Navigator.pop(context);
                                  Get.to(() => const LicensedCollector());
                                  // print(
                                  //     '${controllerUsername.text} ${controllerPassword.text}');
                                  break;
                                case 'C':
                                  setState(() {
                                    _toggleVisible = false;
                                  });
                                  Navigator.pop(context);
                                  Get.to(() => const GeneralCollector(backNav: false, collectorName: 'Hi, Maureen!',));
                                  // print(
                                  //     '${controllerUsername.text} ${controllerPassword.text}');
                                  break;
                                case 'D':
                                  setState(() {
                                    _toggleVisible = false;
                                  });
                                  Navigator.pop(context);
                                  Get.to(() => const GeneralDriver(backNav: false,));
                                  // print(
                                  //     '${controllerUsername.text} ${controllerPassword.text}');
                                  break;
                                case 'S':
                                  setState(() {
                                    _toggleVisible = false;
                                  });
                                  Navigator.pop(context);
                                  Get.to(() => const GeneralStation(backNav: false,));
                                  // print(
                                  //     '${controllerUsername.text} ${controllerPassword.text}');
                                  break;
                                case 'M':
                                  setState(() {
                                    _toggleVisible = false;
                                  });
                                  Navigator.pop(context);
                                  Get.to(() => const MrfCollectionCenter());
                                  // print(
                                  //     '${controllerUsername.text} ${controllerPassword.text}');
                                  break;
                                default:
                                  setState(() {
                                    _toggleVisible = true;
                                  });
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
