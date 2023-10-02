import 'package:collectors/src/features/authentication/model/LicensedCollectorsModel.dart';
import 'package:collectors/src/features/authentication/screens/dashboard/dashboard_collector_2.dart';
import 'package:collectors/src/features/authentication/screens/dashboard/dashboard_driver_4.dart';
import 'package:collectors/src/features/authentication/screens/dashboard/dashboard_mrf_3.dart';
import 'package:collectors/src/features/authentication/screens/dashboard/dashboard_register_collector_1.dart';
import 'package:collectors/src/features/authentication/screens/dashboard/dashboard_station_5.dart';
import 'package:collectors/src/features/authentication/screens/login/login_page.dart';
import 'package:collectors/src/features/authentication/screens/onboarding/OnBoarding.dart';
import 'package:collectors/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  //final emailAccount = _authRepo.firebaseUser.value?.email;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream((_auth.userChanges()));
    ever(firebaseUser, _setIntialScreen);
  }

  _setIntialScreen(User? user) {
    //print(user?.email);
    user == null
        ? Get.offAll(() => const OnBoarding())
        //? Get.offAll(() => const LoginPage())
        //: Get.offAll(() => const MrfCollectionCenter());
        : user?.email?.toUpperCase().substring(0, 2) == 'LA'
            ? Get.offAll(() => const LicensedCollector())
            : user?.email?.toUpperCase().substring(0, 2) == 'CA'
                ? Get.offAll(() => const GeneralCollector(
                      backNav: false,
                      collectorName: 'Hi, Chrispine!',
                    ))
                : user?.email?.toUpperCase().substring(0, 2) == 'DA'
                    ? Get.offAll(() => const GeneralDriver(
                          backNav: false,
                        ))
                    : user?.email?.toUpperCase().substring(0, 2) == 'SA'
                        ? Get.offAll(() => const GeneralStation(
                              backNav: false,
                            ))
                        : Get.offAll(() => const MrfCollectionCenter());
  }

  ///Get

  ///Create User
  Future<void> creatUserWithEmailAndPassword(
      String email, String license) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.toLowerCase(),
        password: license.toUpperCase(),
      );
      // firebaseUser != null
      //     ? license.toUpperCase().substring(0, 2) == 'LA'
      //         ? Get.offAll(() => const LicensedCollector())
      //         : license.toUpperCase().substring(0, 2) == 'CA'
      //             ? Get.offAll(() => const GeneralCollector(
      //                   backNav: false,
      //                   collectorName: 'Hi, Chrispine!',
      //                 ))
      //             : license.toUpperCase().substring(0, 2) == 'DA'
      //                 ? Get.offAll(() => const GeneralDriver(
      //                       backNav: false,
      //                     ))
      //                 : license.toUpperCase().substring(0, 2) == 'SA'
      //                     ? Get.offAll(() => const GeneralStation(
      //                           backNav: false,
      //                         ))
      //                     : Get.offAll(() => const MrfCollectionCenter())
      //     : Get.offAll(() => const LoginPage());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.message}');
    }
  }

  ///Login
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      //accountLicense = password;
      //print(password);
      await _auth.signInWithEmailAndPassword( email: email.toLowerCase(), password: password.toUpperCase());
      firebaseUser != null
          //? Get.offAll(() => const MrfCollectionCenter())
          ? password.substring(0, 2) == 'LA'
              ? Get.offAll(() => const LicensedCollector())
              : password.substring(0, 2) == 'CA'
                  ? Get.offAll(() => const GeneralCollector(
                        backNav: false,
                        collectorName: 'Hi, Maureen!',
                      ))
                  : password.substring(0, 2) == 'DA'
                      ? Get.offAll(() => const GeneralDriver(
                            backNav: false,
                          ))
                      : password.substring(0, 2) == 'SA'
                          ? Get.offAll(() => const GeneralStation(
                                backNav: false,
                              ))
                          : Get.offAll(() => const MrfCollectionCenter())
          : Get.offAll(() => const LoginPage());
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

  ///Logout
  Future<void> logout() async => await _auth.signOut();
}
