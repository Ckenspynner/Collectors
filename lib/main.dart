
import 'package:collectors/firebase_options.dart';
import 'package:collectors/src/features/authentication/screens/splash_screen/Splashscreen.dart';
import 'package:collectors/src/repository/authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

Color appDark = const Color(0xff1c162e);
Color appGreen = const Color(0xff23d99d);
Color appGold = const Color(0xffcfa339);
Color appWhite = const Color(0xffffffff);

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      //theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRight,//leftToRightWithFade,
      transitionDuration: Duration(milliseconds: 500),
      home: Scaffold(
        //body: Center(child: MyLogin()),
        body: Center(child: SplashPage()),
        //body: Center(child: CircularProgressIndicator()),
        //body: Center(child: CollectorFormWidget()),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Flutter',
  //     debugShowCheckedModeBanner: false,
  //     scrollBehavior: MyCustomScrollBehavior(),
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //     ),
  //     home: const Scaffold(
  //       body: SingleChildScrollView(
  //         //child: LicensedCollector(),
  //         //child: GeneralCollector(),
  //         //child: MrfCollectionCenter(),
  //           child: SplashPage(),
  //         //child: LoginPage(),
  //       ),
  //     ),
  //   );
  // }
}
