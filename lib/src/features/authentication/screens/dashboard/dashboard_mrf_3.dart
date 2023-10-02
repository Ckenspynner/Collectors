import 'dart:ui';

import 'package:collectors/main.dart';
import 'package:collectors/src/constants/image_strings.dart';
import 'package:collectors/src/features/authentication/screens/Collectors/list/CollectList.dart';
import 'package:collectors/src/features/authentication/screens/dashboard/dashboard_driver_4.dart';
import 'package:collectors/src/features/authentication/screens/registered/add/registeredCollector.dart';
import 'package:collectors/src/features/authentication/screens/stations/add_trucks_stations.dart';
import 'package:collectors/src/repository/authentication_repository/authentication_repository.dart';
import 'package:collectors/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MrfCollectionCenter extends StatefulWidget {
  const MrfCollectionCenter({Key? key}) : super(key: key);

  @override
  State<MrfCollectionCenter> createState() => _MrfCollectionCenterState();
}

class _MrfCollectionCenterState extends State<MrfCollectionCenter> {
  bool _toggleMobile = true;
  bool _toggleQR = false;
  bool _togglePRO = false;
  bool _toggleAgents = false;
  bool _toggleUtilities = false;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Transform.scale(
            scale: 0.6,
            child: Image.asset(
              home_icon,
            ),
          ),

          title: Container(
            // welcomejonecau (4:3410)
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
            child: RichText(
              text: TextSpan(
                style: SafeGoogleFont(
                  'Inria Sans',
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.5 * ffem / fem,
                  letterSpacing: 0.16 * fem,
                  color: const Color(0xff1c162e),
                ),
                children: [
                  TextSpan(
                    text: 'Welcome',
                    style: SafeGoogleFont(
                      'Inria Sans',
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * ffem / fem,
                      letterSpacing: 0.16 * fem,
                      color: const Color(0xff1c162e),
                    ),
                  ),
                  const TextSpan(
                    text: ' Back',
                  ),
                ],
              ),
            ),
          ),
          //centerTitle: true,
          elevation: 0,
          backgroundColor: appWhite,
          //backgroundColor: const Color(0xfffdfdfe),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10, top: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Wrap(spacing: -8, children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    AuthenticationRepository.instance.logout();
                    // Navigator.pop(context);
                    // Get.to(() => const LoginPage());
                  },
                  icon: Icon(
                    Icons.logout_outlined,
                    color: appGold,
                  ),
                ),
              ]),
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: double.infinity,
            child: Container(
              // dashboard2MX (4:3251)
              padding: EdgeInsets.fromLTRB(0 * fem, 14 * fem, 0 * fem, 0 * fem),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // autogroupfnfkq6h (CGieGnmwykajyS2cyZfNfK)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 30 * fem),
                    width: 392 * fem,
                    height: 64 * fem,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20 * fem,
                            ),
                            GestureDetector(
                                child: Container(
                                  // component8Maq (4:4132)
                                  padding: EdgeInsets.fromLTRB(
                                      14 * fem, 12 * fem, 16 * fem, 9 * fem),
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: _toggleMobile ? appGold : appWhite,
                                    borderRadius:
                                        BorderRadius.circular(12 * fem),
                                    boxShadow: [
                                      // _toggleMobile ?
                                      BoxShadow(
                                        color: const Color(0x14404040),
                                        offset: Offset(0 * fem, 8 * fem),
                                        blurRadius: 10 * fem,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // component7iconsphonenumberDd3 (I4:4132;10081:13425)
                                        margin: EdgeInsets.fromLTRB(
                                            3 * fem, 0 * fem, 0 * fem, 8 * fem),
                                        width: 19 * fem,
                                        height: 19 * fem,
                                        child: Image.asset(
                                          mobile_icon,
                                          width: 19 * fem,
                                          height: 19 * fem,
                                        ),
                                      ),
                                      Text(
                                        // mobilepsj (I4:4132;10081:13424)
                                        'Mobile',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont(
                                          'Inria Sans',
                                          fontSize: 11 * ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.4545454545 * ffem / fem,
                                          color: appDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    _toggleMobile = true;
                                    _toggleQR = false;
                                    _togglePRO = false;
                                    _toggleAgents = false;
                                    _toggleUtilities = false;
                                  });
                                }),
                            SizedBox(
                              width: 18 * fem,
                            ),
                            GestureDetector(
                              child: Container(
                                // component8jjo (4:4133)
                                padding: EdgeInsets.fromLTRB(
                                    9 * fem, 14 * fem, 11 * fem, 9 * fem),
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  //color: Color(0xffffffff),
                                  color: _toggleQR ? appGold : appWhite,
                                  borderRadius: BorderRadius.circular(12 * fem),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x14404040),
                                      offset: Offset(0 * fem, 8 * fem),
                                      blurRadius: 10 * fem,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // component7iconsscandaH (I4:4133;10081:13425)
                                      margin: EdgeInsets.fromLTRB(
                                          2 * fem, 0 * fem, 0 * fem, 9 * fem),
                                      width: 16 * fem,
                                      height: 16 * fem,
                                      child: Image.asset(
                                        qr_code_icon,
                                        width: 16 * fem,
                                        height: 16 * fem,
                                      ),
                                    ),
                                    Text(
                                      // mobileZTw (I4:4133;10081:13424)
                                      'QR Code',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont(
                                        'Inria Sans',
                                        fontSize: 12 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3333333333 * ffem / fem,
                                        letterSpacing: 0.12 * fem,
                                        color: Color(0xff1c162e),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _toggleMobile = false;
                                  _toggleQR = true;
                                  _togglePRO = false;
                                  _toggleAgents = false;
                                  _toggleUtilities = false;
                                });
                                Get.to(() => const GeneralDriver(backNav: true,));
                              },
                            ),
                            SizedBox(
                              width: 18 * fem,
                            ),
                            GestureDetector(
                              child: Container(
                                // component8VcV (4:4134)
                                padding: EdgeInsets.fromLTRB(
                                    19 * fem, 14 * fem, 21 * fem, 9 * fem),
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: _togglePRO ? appGold : appWhite,
                                  borderRadius: BorderRadius.circular(12 * fem),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x14404040),
                                      offset: Offset(0 * fem, 8 * fem),
                                      blurRadius: 10 * fem,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // component7iconsdiceyXf (I4:4134;10081:13425)
                                      margin: EdgeInsets.fromLTRB(
                                          2 * fem, 0 * fem, 0 * fem, 9 * fem),
                                      width: 16 * fem,
                                      height: 16 * fem,
                                      child: Image.asset(
                                        more_options,
                                        width: 16 * fem,
                                        height: 16 * fem,
                                      ),
                                    ),
                                    Text(
                                      // mobile28Z (I4:4134;10081:13424)
                                      'PRO S',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont(
                                        'Inria Sans',
                                        fontSize: 12 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3333333333 * ffem / fem,
                                        letterSpacing: 0.12 * fem,
                                        color: Color(0xff1c162e),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _toggleMobile = false;
                                  _toggleQR = false;
                                  _togglePRO = true;
                                  _toggleAgents = false;
                                  _toggleUtilities = false;
                                });
                              },
                            ),
                            SizedBox(
                              width: 18 * fem,
                            ),
                            GestureDetector(
                              child: Container(
                                // component8Luw (4:4135)
                                padding: EdgeInsets.fromLTRB(
                                    10 * fem, 13 * fem, 12 * fem, 9 * fem),
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: _toggleAgents ? appGold : appWhite,
                                  borderRadius: BorderRadius.circular(12 * fem),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x14404040),
                                      offset: Offset(0 * fem, 8 * fem),
                                      blurRadius: 10 * fem,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // component7iconszips2Xs (I4:4135;10081:13425)
                                      margin: EdgeInsets.fromLTRB(
                                          2 * fem, 0 * fem, 0 * fem, 8 * fem),
                                      width: 18 * fem,
                                      height: 18 * fem,
                                      child: Image.asset(
                                        utilities_icon,
                                        width: 18 * fem,
                                        height: 18 * fem,
                                      ),
                                    ),
                                    Text(
                                      // mobileXjX (I4:4135;10081:13424)
                                      'AGENTS',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont(
                                        'Inria Sans',
                                        fontSize: 12 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3333333333 * ffem / fem,
                                        letterSpacing: 0.12 * fem,
                                        color: const Color(0xff1c162e),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _toggleMobile = false;
                                  _toggleQR = false;
                                  _togglePRO = false;
                                  _toggleAgents = true;
                                  _toggleUtilities = false;
                                });

                                Get.to(() => const CollectorListData(Agent: '',));
                              },
                            ),
                            SizedBox(
                              width: 18 * fem,
                            ),
                            GestureDetector(
                              child: Container(
                                // component9Tt5 (4:4136)
                                padding: EdgeInsets.fromLTRB(
                                    10 * fem, 13 * fem, 12 * fem, 9 * fem),
                                width: 64 * fem,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: _toggleUtilities ? appGold : appWhite,
                                  borderRadius: BorderRadius.circular(12 * fem),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x14404040),
                                      offset: Offset(0 * fem, 8 * fem),
                                      blurRadius: 10 * fem,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // component7iconszipsB3P (I4:4136;10081:13425)
                                      margin: EdgeInsets.fromLTRB(
                                          2 * fem, 0 * fem, 0 * fem, 8 * fem),
                                      width: 18 * fem,
                                      height: 18 * fem,
                                      child: Image.asset(
                                        utility_icon,
                                        width: 18 * fem,
                                        height: 18 * fem,
                                      ),
                                    ),
                                    Text(
                                      // mobileHs7 (I4:4136;10081:13424)
                                      'Utilities',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont(
                                        'Inria Sans',
                                        fontSize: 12 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3333333333 * ffem / fem,
                                        letterSpacing: 0.12 * fem,
                                        color: Color(0xff1c162e),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _toggleMobile = false;
                                  _toggleQR = false;
                                  _togglePRO = false;
                                  _toggleAgents = false;
                                  _toggleUtilities = true;
                                });
                              },
                            ),
                            SizedBox(
                              width: 20 * fem,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // group127242bj (1:990)
                    margin: EdgeInsets.fromLTRB(
                        20 * fem, 0 * fem, 143 * fem, 27 * fem),
                    width: double.infinity,
                    height: 24 * fem,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7 * fem),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // totalincomeiDf (1:991)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 22 * fem, 0 * fem),
                          child: Text(
                            'Total Weight',
                            style: SafeGoogleFont(
                              'Inria Sans',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.7142857143 * ffem / fem,
                              color: Color(0xff1c162e),
                            ),
                          ),
                        ),
                        Container(
                          // group12723M1j (1:992)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 2 * fem, 0 * fem, 2 * fem),
                          padding: EdgeInsets.fromLTRB(
                              7 * fem, 0 * fem, 6 * fem, 0 * fem),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7 * fem),
                            gradient: const LinearGradient(
                              begin: Alignment(-1, -0),
                              end: Alignment(1, -0),
                              colors: <Color>[
                                Color(0xff1ad5ad),
                                Color(0xff23d99d)
                              ],
                              stops: <double>[0, 1],
                            ),
                          ),
                          child: Text(
                            'This week',
                            style: SafeGoogleFont(
                              'Inria Sans',
                              fontSize: 15 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.1975 * ffem / fem,
                              letterSpacing: 0.15 * fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // autogroupgjbbxGR (CGi3hT41qgbR5fTYdUgJBb)
                    width: double.infinity,
                    height: 140 * fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // cardtokenbonushUu (1:977)
                          margin: EdgeInsets.fromLTRB(
                              20 * fem, 0 * fem, 19 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              39 * fem, 16 * fem, 39 * fem, 22 * fem),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(16 * fem),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x14404040),
                                offset: Offset(0 * fem, 8 * fem),
                                blurRadius: 10 * fem,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // autogroup8cxs961 (CGi3rcTR4AGWM5SSBL8CXs)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 12 * fem),
                                width: 40 * fem,
                                height: 40 * fem,
                                child: Image.asset(
                                  wet_icon,
                                  width: 40 * fem,
                                  height: 40 * fem,
                                ),
                              ),
                              Container(
                                // Qnd (1:981)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                child: Text(
                                  '300.65 t',
                                  style: SafeGoogleFont(
                                    'Inria Sans',
                                    fontSize: 20 * ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.4 * ffem / fem,
                                    color: Color(0xff1c162e),
                                  ),
                                ),
                              ),
                              Container(
                                // peopleswXf (1:979)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 8 * fem, 0 * fem),
                                child: Text(
                                  'Wet',
                                  style: SafeGoogleFont(
                                    'Inria Sans',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.1975 * ffem / fem,
                                    letterSpacing: 0.15 * fem,
                                    color: Color(0xffc6c4ca),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // cardtokenbonusDk5 (1:982)
                          padding: EdgeInsets.fromLTRB(
                              48 * fem, 16 * fem, 48 * fem, 22 * fem),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(16 * fem),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x14404040),
                                offset: Offset(0 * fem, 8 * fem),
                                blurRadius: 10 * fem,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // autogroupxx4mJFj (CGi3zC57svFdLeTdBqxX4M)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 12 * fem),
                                width: 40 * fem,
                                height: 40 * fem,
                                child: Image.asset(
                                  sun_icon,
                                  width: 40 * fem,
                                  height: 40 * fem,
                                ),
                              ),
                              Container(
                                // hYm (1:986)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                child: Text(
                                  '100.67 t',
                                  style: SafeGoogleFont(
                                    'Inria Sans',
                                    fontSize: 20 * ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.4 * ffem / fem,
                                    color: const Color(0xff1c162e),
                                  ),
                                ),
                              ),
                              Container(
                                // spotsEHo (1:984)
                                margin: EdgeInsets.fromLTRB(
                                    1 * fem, 0 * fem, 0 * fem, 0 * fem),
                                child: Text(
                                  'Dry',
                                  style: SafeGoogleFont(
                                    'Inria Sans',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.1975 * ffem / fem,
                                    letterSpacing: 0.15 * fem,
                                    color: const Color(0xffc6c4ca),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // autogroupdq2hgsb (CGiRrtxUKdFesAyEyndq2h)
                    padding: EdgeInsets.fromLTRB(
                        20 * fem, 0 * fem, 20 * fem, 0 * fem),
                    width: double.infinity,
                    //height: 623*fem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // rectangle688nQq (4:3404)
                          margin: EdgeInsets.fromLTRB(
                              153 * fem, 0 * fem, 152 * fem, 20 * fem),
                          width: double.infinity,
                          height: 4 * fem,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26 * fem),
                            color: Color(0x2bffffff),
                          ),
                        ),
                        Container(
                          // autogroupabpwuVT (CGiPKightnARTffEjLabPw)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 10 * fem, 0 * fem, 0 * fem),
                          width: double.infinity,
                          height: 211 * fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // autogroupkhxmF3X (CGiPTt7mhkTKc8JDCfKhxm)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 17 * fem, 0 * fem),
                                width: 50 * fem,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // group12696kW5 (4:3411)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 9 * fem),
                                      padding: EdgeInsets.fromLTRB(17 * fem,
                                          22.38 * fem, 17 * fem, 21.38 * fem),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff1c162e),
                                        borderRadius:
                                            BorderRadius.circular(12 * fem),
                                      ),
                                      child: Center(
                                        // component7iconsstaticsc2V (4:3413)
                                        child: SizedBox(
                                          width: 16 * fem,
                                          height: 15.24 * fem,
                                          child: Image.asset(
                                            bar_icon,
                                            width: 16 * fem,
                                            height: 15.24 * fem,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // group12719jcu (4:3414)
                                      width: 40 * fem,
                                      height: 40 * fem,
                                      child: Image.asset(
                                        copy_icon,
                                        width: 40 * fem,
                                        height: 40 * fem,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // group12720FLM (4:3417)
                                padding: EdgeInsets.fromLTRB(
                                    18 * fem, 12 * fem, 14 * fem, 11 * fem),
                                width: 268 * fem,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13 * fem),
                                  gradient: const LinearGradient(
                                    begin: Alignment(-2, 0),
                                    end: Alignment(0, 2),
                                    colors: <Color>[
                                      Color(0xff2cc8ea),
                                      Color(0xff14d2b8)
                                    ],
                                    stops: <double>[0, 1],
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // autogroupt7foijj (CGiPnYFMGYGEWc3HzYT7Fo)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 5 * fem, 0 * fem),
                                      width: double.infinity,
                                      height: 25 * fem,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // amounte7b (4:3425)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 70 * fem, 1 * fem),
                                            child: Text(
                                              'Collection Graph',
                                              style: SafeGoogleFont(
                                                'Inria Sans',
                                                fontSize: 18 * ffem,
                                                fontWeight: FontWeight.w700,
                                                height: 1.1975 * ffem / fem,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3 * fem,
                                    ),
                                    Text(
                                      // typefS1 (4:3424)
                                      '52721',
                                      style: SafeGoogleFont(
                                        'Inria Sans',
                                        fontSize: 12 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.25 * ffem / fem,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3 * fem,
                                    ),
                                    Container(
                                      // autogroupacy9bqT (CGiPxnTHAywCVPJvYUACY9)
                                      width: double.infinity,
                                      height: 119 * fem,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            // group12714YEu (4:3426)
                                            left: 0 * fem,
                                            top: 19 * fem,
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  5 * fem),
                                              width: 236 * fem,
                                              height: 95 * fem,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // gEd (4:3427)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        4 * fem),
                                                    child: Text(
                                                      '100',
                                                      style: SafeGoogleFont(
                                                        'Inria Sans',
                                                        fontSize: 10 * ffem,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        height:
                                                            1.1975 * ffem / fem,
                                                        letterSpacing: 2 * fem,
                                                        color:
                                                            Color(0xffffffff),
                                                      ),
                                                    ),
                                                  ),
                                                  Opacity(
                                                    // divideroa9 (4:3431)
                                                    opacity: 0.081,
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              22 * fem),
                                                      width: double.infinity,
                                                      height: 1 * fem,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            Color(0x14ffffff),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    // 8cR (4:3428)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        4 * fem),
                                                    child: Text(
                                                      '50',
                                                      style: SafeGoogleFont(
                                                        'Inria Sans',
                                                        fontSize: 10 * ffem,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        height:
                                                            1.1975 * ffem / fem,
                                                        letterSpacing: 2 * fem,
                                                        color:
                                                            Color(0xffffffff),
                                                      ),
                                                    ),
                                                  ),
                                                  Opacity(
                                                    // dividerpEM (4:3429)
                                                    opacity: 0.081,
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              22 * fem),
                                                      width: double.infinity,
                                                      height: 1 * fem,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            Color(0x14ffffff),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    // uWh (4:3432)
                                                    '0',
                                                    style: SafeGoogleFont(
                                                      'Inria Sans',
                                                      fontSize: 10 * ffem,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height:
                                                          1.1975 * ffem / fem,
                                                      letterSpacing: 2 * fem,
                                                      color: Color(0xffffffff),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            // group12717FqT (4:3438)
                                            left: 33 * fem,
                                            top: 7 * fem,
                                            child: Container(
                                              width: 202.09 * fem,
                                              height: 112 * fem,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                    shade_line_icon,
                                                  ),
                                                ),
                                              ),
                                              child: Align(
                                                // line1knD (4:3440)
                                                alignment: Alignment.topCenter,
                                                child: SizedBox(
                                                  width: 202.06 * fem,
                                                  height: 87.79 * fem,
                                                  child: Image.asset(
                                                    line_icon,
                                                    width: 202.06 * fem,
                                                    height: 87.79 * fem,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            // oval6LH (4:3441)
                                            left: 92 * fem,
                                            top: 23 * fem,
                                            child: Align(
                                              child: SizedBox(
                                                width: 15 * fem,
                                                height: 15 * fem,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.5 * fem),
                                                    border: Border.all(
                                                        color:
                                                            Color(0xffffffff)),
                                                    color: Color(0xff22cdd5),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0xcc232f6f),
                                                        offset: Offset(
                                                            0 * fem, 7 * fem),
                                                        blurRadius: 5 * fem,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            // group12718wrh (4:3442)
                                            left: 100 * fem,
                                            top: 0 * fem,
                                            child: Container(
                                              width: 34 * fem,
                                              height: 30 * fem,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                    label_icon,
                                                  ),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '800t',
                                                  style: SafeGoogleFont(
                                                    'Inria Sans',
                                                    fontSize: 12 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.1975 * ffem / fem,
                                                    color: Color(0xffffffff),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3 * fem,
                                    ),
                                    Container(
                                      // autogroup62xbk3T (CGiQF2VDWTuKBte3Za62XB)
                                      margin: EdgeInsets.fromLTRB(38.5 * fem,
                                          0 * fem, 0 * fem, 0 * fem),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            // jangSu (4:3419)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 0 * fem),
                                            child: Text(
                                              ' JAN',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'Inria Sans',
                                                fontSize: 10 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 2 * ffem / fem,
                                                letterSpacing: 2 * fem,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            // febnVw (4:3423)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 0 * fem),
                                            child: Text(
                                              'FEB',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'Inria Sans',
                                                fontSize: 10 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 2 * ffem / fem,
                                                letterSpacing: 2 * fem,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            // maruqT (4:3422)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 0 * fem),
                                            child: Text(
                                              'MAR',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'Inria Sans',
                                                fontSize: 10 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 2 * ffem / fem,
                                                letterSpacing: 2 * fem,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            // aprF8d (4:3421)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 0 * fem),
                                            child: Text(
                                              'APR',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'Inria Sans',
                                                fontSize: 10 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 2 * ffem / fem,
                                                letterSpacing: 2 * fem,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            // mayAFb (4:3420)
                                            'MAY',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'Inria Sans',
                                              fontSize: 10 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 2 * ffem / fem,
                                              letterSpacing: 2 * fem,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // autogroupuwzhz9F (CGiM8HM3igsyg1P4GquwzH)
                    padding: EdgeInsets.fromLTRB(
                        0 * fem, 16 * fem, 0 * fem, 48 * fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // group12724MtD (4:3271)
                          margin: EdgeInsets.fromLTRB(
                              20 * fem, 20 * fem, 0 * fem, 24 * fem),
                          width: double.infinity,
                          height: 24 * fem,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7 * fem),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // tokenbonustdF (4:3272)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 24 * fem, 0 * fem),
                                child: RichText(
                                  text: TextSpan(
                                    style: SafeGoogleFont(
                                      'Inria Sans',
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.7142857143 * ffem / fem,
                                      color: Color(0xff1c162e),
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'Recycled ',
                                      ),
                                      TextSpan(
                                        text: 'Waste',
                                        style: SafeGoogleFont(
                                          'Inria Sans',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.7142857143 * ffem / fem,
                                          color: Color(0xff1c162e),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                // group12723iEu (4:3273)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 2 * fem, 0 * fem, 2 * fem),
                                padding: EdgeInsets.fromLTRB(
                                    7 * fem, 0 * fem, 7 * fem, 0 * fem),
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7 * fem),
                                  gradient: const LinearGradient(
                                    begin: Alignment(2.082, 0.164),
                                    end: Alignment(0.082, -2),
                                    colors: <Color>[
                                      Color(0xffe83e93),
                                      Color(0xfff44e5e)
                                    ],
                                    stops: <double>[0, 1],
                                  ),
                                ),
                                child: Text(
                                  'This Week',
                                  style: SafeGoogleFont(
                                    'Inria Sans',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.1975 * ffem / fem,
                                    letterSpacing: 0.15 * fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // autogroupsac16mF (CGiLRigJXDGXix2fgrsac1)
                          margin: EdgeInsets.fromLTRB(
                              20 * fem, 0 * fem, 20 * fem, 28 * fem),
                          width: double.infinity,
                          height: 220 * fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // cardtokenbonus1NR (4:3276)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 15 * fem, 0 * fem),
                                padding: EdgeInsets.fromLTRB(
                                    38 * fem, 32 * fem, 37 * fem, 22 * fem),
                                width: 160 * fem,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xff1c162e),
                                  borderRadius: BorderRadius.circular(12 * fem),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x7f7d64ff),
                                      offset: Offset(0 * fem, 8 * fem),
                                      blurRadius: 10 * fem,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // group127255NH (4:3277)
                                      margin: EdgeInsets.fromLTRB(
                                          8 * fem, 0 * fem, 9 * fem, 24 * fem),
                                      width: double.infinity,
                                      height: 68 * fem,
                                      decoration: BoxDecoration(
                                        color: const Color(0x19ffffff),
                                        borderRadius:
                                            BorderRadius.circular(34 * fem),
                                        image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            pie_green,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '52%',
                                          style: SafeGoogleFont(
                                            'Inria Sans',
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.1975 * ffem / fem,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // tokenstobuyfor13L3K (4:3281)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 22 * fem),
                                      constraints: BoxConstraints(
                                        maxWidth: 85 * fem,
                                      ),
                                      child: Text(
                                        '48% ready for recycle',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont(
                                          'Inria Sans',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.1975 * ffem / fem,
                                          color: Color(0xfff2f2f2),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // btnbV3 (4:3282)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 1 * fem, 0 * fem),
                                      child: Text(
                                        '330BTN',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont(
                                          'Inria Sans',
                                          fontSize: 15 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.1975 * ffem / fem,
                                          letterSpacing: 0.15 * fem,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // autogroupsicrKfw (CGiLYDVUf1Fn19m7hJSiCR)
                                width: 160 * fem,
                                height: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // cardtokenbonus5QD (4:3283)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                      padding: EdgeInsets.fromLTRB(16 * fem,
                                          20 * fem, 16 * fem, 19 * fem),
                                      width: double.infinity,
                                      height: 80 * fem,
                                      decoration: BoxDecoration(
                                        color: Color(0xffffffff),
                                        borderRadius:
                                            BorderRadius.circular(12 * fem),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x14404040),
                                            offset: Offset(0 * fem, 8 * fem),
                                            blurRadius: 10 * fem,
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        // group12726kWM (4:3284)
                                        width: 100 * fem,
                                        height: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // bonusreceivedWEd (4:3285)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  6 * fem),
                                              child: Text(
                                                'Recycled Wet',
                                                style: SafeGoogleFont(
                                                  'Inria Sans',
                                                  fontSize: 15 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.1975 * ffem / fem,
                                                  letterSpacing: 0.15 * fem,
                                                  color: Color(0xffc6c4ca),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              // kuf (4:3286)
                                              '22%',
                                              style: SafeGoogleFont(
                                                'Inria Sans',
                                                fontSize: 14 * ffem,
                                                fontWeight: FontWeight.w700,
                                                height: 1.1975 * ffem / fem,
                                                color: Color(0xff1c162e),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // cardtokenbonusi5o (4:3287)
                                      padding: EdgeInsets.fromLTRB(16 * fem,
                                          10 * fem, 16 * fem, 27 * fem),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xffffffff),
                                        borderRadius:
                                            BorderRadius.circular(12 * fem),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x14404040),
                                            offset: Offset(0 * fem, 8 * fem),
                                            blurRadius: 10 * fem,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // buttonsiconbuttonmediumyXX (4:3290)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 12 * fem),
                                            width: 34 * fem,
                                            height: 34 * fem,
                                            child: Image.asset(
                                              utilities_icon,
                                              width: 34 * fem,
                                              height: 34 * fem,
                                            ),
                                          ),
                                          Container(
                                            // bonusreceivedJJu (4:3288)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 6 * fem),
                                            child: Text(
                                              'Recycled Dry',
                                              style: SafeGoogleFont(
                                                'Inria Sans',
                                                fontSize: 15 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.1975 * ffem / fem,
                                                letterSpacing: 0.15 * fem,
                                                color: Color(0xffc6c4ca),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            // po3 (4:3289)
                                            '30%',
                                            style: SafeGoogleFont(
                                              'Inria Sans',
                                              fontSize: 14 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 1.1975 * ffem / fem,
                                              color: Color(0xff1c162e),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // autogrouprtpdxPT (CGiLwY9x7VWv8kSUBerTpD)
                          margin: EdgeInsets.fromLTRB(
                              20 * fem, 0 * fem, 20 * fem, 0 * fem),
                          width: double.infinity,
                          height: 44 * fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  // buttonssWR (4:3291)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 15 * fem, 0 * fem),
                                  width: 160 * fem,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xfff2f2f2),
                                    borderRadius:
                                        BorderRadius.circular(12 * fem),
                                  ),
                                  child: Center(
                                    child: Center(
                                      child: Text(
                                        'Add Collectors',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont(
                                          'Inria Sans',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.4285714286 * ffem / fem,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Get.to(() => const RegisteredCollectors());
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                  // buttons8SM (4:3292)
                                  width: 160 * fem,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xfff2f2f2),
                                    borderRadius: BorderRadius.circular(12 * fem),
                                  ),
                                  child: Center(
                                    child: Center(
                                      child: Text(
                                        'Add PRO',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont(
                                          'Inria Sans',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.4285714286 * ffem / fem,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Get.to(() => const TruckStationForm(truckStation: 'Add PRO'));
                                },
                              ),
                            ],
                          ),
                        ),

                        Container(
                          // autogrouprtpdxPT (CGiLwY9x7VWv8kSUBerTpD)
                          margin: EdgeInsets.fromLTRB(
                              20 * fem, 20 * fem, 20 * fem, 0 * fem),
                          width: double.infinity,
                          height: 44 * fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  // buttonssWR (4:3291)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 15 * fem, 0 * fem),
                                  width: 160 * fem,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xfff2f2f2),
                                    borderRadius:
                                    BorderRadius.circular(12 * fem),
                                  ),
                                  child: Center(
                                    child: Center(
                                      child: Text(
                                        'Add Trucks',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont(
                                          'Inria Sans',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.4285714286 * ffem / fem,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Get.to(() => const TruckStationForm(truckStation: 'Add Truck'));
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                  // buttons8SM (4:3292)
                                  width: 160 * fem,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xfff2f2f2),
                                    borderRadius: BorderRadius.circular(12 * fem),
                                  ),
                                  child: Center(
                                    child: Center(
                                      child: Text(
                                        'Add Stations',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont(
                                          'Inria Sans',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.4285714286 * ffem / fem,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Get.to(() => const TruckStationForm(truckStation: 'Add Station'));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
