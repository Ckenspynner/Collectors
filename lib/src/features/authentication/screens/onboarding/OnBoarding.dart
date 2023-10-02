import 'package:collectors/main.dart';
import 'package:collectors/src/constants/image_strings.dart';
import 'package:collectors/src/features/authentication/screens/login/login_page.dart';
import 'package:collectors/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: OnBoardingSlider(
        headerBackgroundColor: Colors.white30,
        finishButtonText: 'Get Started',
        centerBackground: true,
        controllerColor: appGold,
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: appDark,
        ),
        skipTextButton: Text('Skip',style:SafeGoogleFont(
          'Inria Sans',
          fontSize:
          18 * ffem,
          fontWeight:
          FontWeight
              .w400,
          height:
          1.7142857143 *
              ffem /
              fem,
          color: appGold,
        ),),
        // trailing: Text('Login',style:SafeGoogleFont(
        //   'Inria Sans',
        //   fontSize:
        //   18 * ffem,
        //   fontWeight:
        //   FontWeight
        //       .w400,
        //   height:
        //   1.7142857143 *
        //       ffem /
        //       fem,
        //   color: appGold,
        // ),),
        background: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(
                  onboarding_1,
                  width: 350 * fem,
                  height: 420 * fem,
                )),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(
                  onboarding_2,
                  width: 350 * fem,
                  height: 420 * fem,
                )),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(
                  onboarding_3,
                  width: 350 * fem,
                  height: 420 * fem,
                )),
              ],
            ),
          ),
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.8,
                ),
                Text(
                  'Reduce and Recycle',
                  textAlign: TextAlign
                      .center,
                  style:
                  SafeGoogleFont(
                    'Inria Sans',
                    fontSize:
                    24 * ffem,
                    fontWeight:
                    FontWeight
                        .w700,
                    height:
                    1.7142857143 *
                        ffem /
                        fem,
                    color: appDark,
                  ),
                ),
                const SizedBox(height: 20,),
                Text(
                  'Reuse, recycle, and reduce the waste for a better future.',
                  textAlign: TextAlign
                      .center,
                  style:
                  SafeGoogleFont(
                    'Inria Sans',
                    fontSize:
                    14 * ffem,
                    fontWeight:
                    FontWeight
                        .w400,
                    height:
                    1.7142857143 *
                        ffem /
                        fem,
                    color: appDark,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.8,
                ),
                Text(
                  'Reuse',
                  textAlign: TextAlign
                      .center,
                  style:
                  SafeGoogleFont(
                    'Inria Sans',
                    fontSize:
                    24 * ffem,
                    fontWeight:
                    FontWeight
                        .w700,
                    height:
                    1.7142857143 *
                        ffem /
                        fem,
                    color: appDark,
                  ),
                ),
                const SizedBox(height: 20,),
                Text(
                  'Save earth by reusing, recycling waste. Think before your trash.',
                  textAlign: TextAlign
                      .center,
                  style:
                  SafeGoogleFont(
                    'Inria Sans',
                    fontSize:
                    14 * ffem,
                    fontWeight:
                    FontWeight
                        .w400,
                    height:
                    1.7142857143 *
                        ffem /
                        fem,
                    color: appDark,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.8,
                ),
                Text(
                  'Save The Earth',
                  textAlign: TextAlign
                      .center,
                  style:
                  SafeGoogleFont(
                    'Inria Sans',
                    fontSize:
                    24 * ffem,
                    fontWeight:
                    FontWeight
                        .w700,
                    height:
                    1.7142857143 *
                        ffem /
                        fem,
                    color: appDark,
                  ),
                ),
                const SizedBox(height: 20,),
                Text(
                  'Increase greenery by recycling waste. Be a recycler, be a saver.',
                  textAlign: TextAlign
                      .center,
                  style:
                  SafeGoogleFont(
                    'Inria Sans',
                    fontSize:
                    14 * ffem,
                    fontWeight:
                    FontWeight
                        .w400,
                    height:
                    1.7142857143 *
                        ffem /
                        fem,
                    color: appDark,
                  ),
                ),
              ],
            ),
          ),
        ],
        onFinish: () {
          Navigator.pop(context);
          Get.offAll(() => const LoginPage());
        },
      ),
    );
  }
}
