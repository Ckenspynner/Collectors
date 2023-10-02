import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collectors/main.dart';
import 'package:collectors/src/constants/image_strings.dart';
import 'package:collectors/src/constants/text_strings.dart';
import 'package:collectors/src/features/authentication/model/LicensedCollectorsModel.dart';
import 'package:collectors/src/features/authentication/screens/Collectors/add/collector_form_widget.dart';
import 'package:collectors/src/features/authentication/screens/Collectors/list/CollectList.dart';
import 'package:collectors/src/features/authentication/screens/dashboard/dashboard_collector_2.dart';
import 'package:collectors/src/features/authentication/screens/login/login_page.dart';
import 'package:collectors/src/features/authentication/screens/splash_screen/Splashscreen.dart';
import 'package:collectors/src/features/authentication/screens/stations/TruckList.dart';
import 'package:collectors/src/features/authentication/screens/statistics/CollectorTable.dart';
import 'package:collectors/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../utils/utils.dart';

String currentDate = DateFormat('d/M/yyyy').format(DateTime.now());

class LicensedCollector extends StatefulWidget {
  const LicensedCollector({Key? key}) : super(key: key);

  @override
  State<LicensedCollector> createState() => _LicensedCollectorState();
}

class _LicensedCollectorState extends State<LicensedCollector> {
  bool toggleAdd = true;
  bool toggleList = false;
  bool toggleStatistics = false;
  bool toggleStations = false;
  var splitName, SupervisorIdentity, UserAcountName,DriverIdentity;
  List totalCollectors = [];
  var totalWetWeight = 0.0, totalDryWeight = 0.0;
  final _authRepo = Get.put(AuthenticationRepository());

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final emailAccount = _authRepo.firebaseUser.value?.email;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Transform.scale(
              scale: 0.6,
              child: Image.asset(
                home_icon,
              ),
            ),
            onTap: () {
              //var splitName = UserAcountName.split(" ");
              //print(UserAcountName);
              //Navigator.pop(context);
              Get.to(() => GeneralCollector(
                backNav: true,
                collectorName: '$UserAcountName $DriverIdentity',//,/'Hi, ${splitName[0]}!',
                collectorLicense: DriverIdentity,//,/'Hi, ${splitName[0]}!',
              ));
            },
          ),

          title: Container(
            // welcomejonecau (4:3410)
            margin:
            EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
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
          foregroundColor: appDark,
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
            height: MediaQuery.of(context).size.height,
            child: Container(
              // chart3fP (4:3946)
              padding: EdgeInsets.fromLTRB(
                  0 * fem, 0 * fem, 0 * fem, 0 * fem),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // autogroupqmwz4eM (CGiYSnpURc2aG65ejYqmWZ)
                    padding: EdgeInsets.fromLTRB(
                        20 * fem, 20 * fem, 20 * fem, 8 * fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // group12768Pgd (4:3950)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 40 * fem),
                          padding: EdgeInsets.fromLTRB(20 * fem,
                              18.38 * fem, 18 * fem, 23 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xff1c162e),
                            borderRadius:
                            BorderRadius.circular(12 * fem),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x7f7d64ff),
                                offset: Offset(0 * fem, 8 * fem),
                                blurRadius: 10 * fem,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                // autogroupqd7fesT (CGiYhhZJDk9mTzHYywqD7f)
                                width: double.infinity,
                                height: 68.62 * fem,
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // rectangle536b21 (4:3967)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem,
                                          1.62 * fem,
                                          15 * fem,
                                          0 * fem),
                                      width: 67 * fem,
                                      height: 67 * fem,
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(
                                            4 * fem),
                                        child: Image.asset(
                                          profile,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    FutureBuilder(

                                      future: controller.getLicensedCollectorData(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          if (snapshot.hasData) {
                                            LicensedCollectorModel
                                            licensedCollectorData =
                                            snapshot.data as LicensedCollectorModel;
                                            // splitName = licensedCollectorData
                                            //     .username
                                            //     .split(" ");
                                            SupervisorIdentity =
                                                licensedCollectorData
                                                    .supervisorIdentity;
                                            UserAcountName =
                                                licensedCollectorData.username;
                                            DriverIdentity = licensedCollectorData.license;

                                            //print(licensedCollectorData.supervisorIdentity);
                                            //return Center(child: Text(licensedCollectorData.username));
                                            return Container(
                                              // autogroup2mumuYV (CGiYnwuZ6eumqzqc9E2MUm)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  12.62 * fem,
                                                  45 * fem,
                                                  10 * fem),
                                              height: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // youearneddUV (4:3965)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        5 * fem),
                                                    child: Text(
                                                      UserAcountName,
                                                      style: SafeGoogleFont(
                                                        'Inria Sans',
                                                        fontSize: 14 * ffem,
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        height:
                                                        1.1975 * ffem / fem,
                                                        color: const Color(
                                                            0xff23d99d),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    // usdtodaystd (4:3966)
                                                    licensedCollectorData.license,
                                                    style: SafeGoogleFont(
                                                      'Inria Sans',
                                                      fontSize: 20 * ffem,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      height:
                                                      1.1975 * ffem / fem,
                                                      color: const Color(
                                                          0xffffffff),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );

                                          } else if (snapshot.hasError) {
                                            return Center(
                                                child: Text(snapshot.error.toString()));
                                          } else {
                                            return const Center(
                                                child: Text('Something Went Wrong'));
                                          }
                                        } else {
                                          return Center(
                                            child:
                                            LoadingAnimationWidget.staggeredDotsWave(
                                              color: appGold,
                                              size: 30,
                                            ),
                                          );
                                        }
                                      },
                                      //child: Center(child: Text('Okobo'))
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            // menunavigationgrid1528RQM (4:3952)
                                            // width: 16 * fem,
                                            // height: 15.24 * fem,
                                            child: Image.asset(
                                              more_details,
                                              width: 16 * fem,
                                              height: 15.24 * fem,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20 * fem,
                              ),
                              Container(
                                // rectangle706wdb (4:3964)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 2 * fem, 0 * fem),
                                width: 295 * fem,
                                height: 1 * fem,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(1 * fem),
                                  color: const Color(0x19ffffff),
                                ),
                              ),
                              SizedBox(
                                height: 20 * fem,
                              ),


                              FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection('AgentScannerCollections')
                                    .where("SupervisorIdentity", isEqualTo: emailAccount)
                                    .where("CurrentDate", isEqualTo: currentDate)
                                    .get(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text("Something went wrong");
                                  }

                                  totalWetWeight = 0.0;
                                  totalDryWeight = 0.0;

                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    totalCollectors = [];
                                    for (var doc in snapshot.data!.docs) {
                                      totalWetWeight += double.parse(doc["Wet"]);
                                      totalDryWeight += double.parse(doc["Dry"]);
                                      totalCollectors.add(doc["Enumerator"]);
                                      //totalHouseholds.add(doc["SourceName"]);

                                      //print(doc["Enumerator"]);
                                    }
                                    // final data = json.decode(
                                    //     "[{\"videoId\":1,\"videoName\":\"Test Video 1\",\"duration\":300,\"createdTime\":\"1969-07-20 20:18:04Z\",\"isWatch\":1},{\"videoId\":1,\"videoName\":\"Test Video 1\",\"duration\":300,\"createdTime\":\"1969-07-20 20:18:04Z\",\"isWatch\":50},{\"videoId\":1,\"videoName\":\"Test Video 1\",\"duration\":300,\"createdTime\":\"1969-07-21 20:18:04Z\",\"isWatch\":20}]");
                                    //
                                    // final map = HashMap<String, dynamic>();
                                    // for (var value in (data as List)) {
                                    //   if (map[value['createdTime']] == null) {
                                    //     map[value['createdTime']] = value['isWatch'];
                                    //   } else {
                                    //     map[value['createdTime']] = map[value['createdTime']] + value['isWatch'];
                                    //   }
                                    // }
                                    //
                                    // print(map);
                                  }

                                  return Container(
                                    // group12521fJh (4:3953)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                    width: double.infinity,
                                    height: 60 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          // group12519aRf (4:3956)
                                          width: 60 * fem,
                                          height: double.infinity,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                // Xrh (4:3957)
                                                // left: 18.5 * fem,
                                                // top: 18 * fem,
                                                child: Center(
                                                  child: Align(
                                                    child: SizedBox(
                                                      //width: 23 * fem,
                                                      //height: 24 * fem,
                                                      child: Text(
                                                        '${totalWetWeight + totalDryWeight}',
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
                                                          color: const Color(
                                                              0xffffffff),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // ellipse209Y17 (4:3958)
                                                left: 0 * fem,
                                                top: 0 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 60 * fem,
                                                    height: 60 * fem,
                                                    child: Container(
                                                      decoration:
                                                      BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            30 *
                                                                fem),
                                                        color: const Color(
                                                            0x19ffffff),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // ellipse208pjK (4:3959)
                                                left: 0 * fem,
                                                top: 0 * fem,
                                                child: Align(
                                                  child: SizedBox(
                                                    width: 60 * fem,
                                                    height: 60 * fem,
                                                    child: Image.asset(
                                                      pie_chart,
                                                      width: 60 * fem,
                                                      height: 60 * fem,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            // autogroupviidxKj (CGiZAwGv1oKzUzPjrsViid)
                                            padding: EdgeInsets.fromLTRB(
                                                12 * fem,
                                                7 * fem,
                                                0 * fem,
                                                7 * fem),
                                            height: double.infinity,
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                  // autogroupiask6Rw (CGiZ4rciJJRAArPRU9iasK)
                                                  margin:
                                                  EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      0 * fem,
                                                      0 * fem),
                                                  height: double.infinity,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Container(
                                                        // totalsaving137 (4:3954)
                                                        margin: EdgeInsets
                                                            .fromLTRB(
                                                            0 * fem,
                                                            0 * fem,
                                                            0 * fem,
                                                            11 * fem),
                                                        child: Text(
                                                          total_collected_label_1,
                                                          style:
                                                          SafeGoogleFont(
                                                            'Inria Sans',
                                                            fontSize:
                                                            14 * ffem,
                                                            fontWeight:
                                                            FontWeight
                                                                .w700,
                                                            height: 1.1975 *
                                                                ffem /
                                                                fem,
                                                            color: const Color(
                                                                0xffffffff),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        // stagemilestone1KpV (4:3955)
                                                        '$total_collected_label_2 ${totalCollectors.toSet().length}',
                                                        style:
                                                        SafeGoogleFont(
                                                          'Inria Sans',
                                                          fontSize:
                                                          15 * ffem,
                                                          fontWeight:
                                                          FontWeight
                                                              .w400,
                                                          height: 1.1975 *
                                                              ffem /
                                                              fem,
                                                          letterSpacing:
                                                          0.15 * fem,
                                                          color: const Color(
                                                              0xffc6c4ca),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  // group12769GDw (4:3960)
                                                  margin:
                                                  EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      2 * fem,
                                                      0 * fem,
                                                      3 * fem),
                                                  padding:
                                                  EdgeInsets.fromLTRB(
                                                      16 * fem,
                                                      12 * fem,
                                                      11 * fem,
                                                      12 * fem),
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        13 * fem),
                                                    gradient:
                                                    const LinearGradient(
                                                      begin:
                                                      Alignment(-1, -0),
                                                      end: Alignment(1, -0),
                                                      colors: <Color>[
                                                        Color(0xff1ad5ad),
                                                        Color(0xff23d99d)
                                                      ],
                                                      stops: <double>[0, 1],
                                                    ),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      // Container(
                                                      //   // 3tu (4:3962)
                                                      //   margin: EdgeInsets.fromLTRB(
                                                      //       0 * fem,
                                                      //       0 * fem,
                                                      //       5 * fem,
                                                      //       0 * fem),
                                                      //   child: Text(
                                                      //     statistics_label,
                                                      //     style: SafeGoogleFont(
                                                      //       'Inria Sans',
                                                      //       fontSize: 14 * ffem,
                                                      //       fontWeight:
                                                      //           FontWeight.w700,
                                                      //       height:
                                                      //           1.1975 * ffem / fem,
                                                      //       color: const Color(
                                                      //           0xffffffff),
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      Container(
                                                        // updownBkD (4:3963)
                                                        margin: EdgeInsets
                                                            .fromLTRB(
                                                            0 * fem,
                                                            1 * fem,
                                                            0 * fem,
                                                            0 * fem),
                                                        width: 16 * fem,
                                                        height: 16 * fem,
                                                        child: Image.asset(
                                                          dropdown_arrow,
                                                          width: 16 * fem,
                                                          height: 16 * fem,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),




                            ],
                          ),
                        ),
                        Container(
                          // group12520tuX (4:3968)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 29 * fem),
                          padding: EdgeInsets.fromLTRB(20 * fem,
                              17 * fem, 22.67 * fem, 17 * fem),
                          width: double.infinity,
                          height: 80 * fem,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xfff3f3f3)),
                            borderRadius:
                            BorderRadius.circular(16 * fem),
                          ),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // group12770myK (4:3970)
                                margin: EdgeInsets.fromLTRB(0 * fem,
                                    0 * fem, 54.67 * fem, 0 * fem),
                                height: double.infinity,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // topupbalancevLR (4:3971)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem,
                                          0 * fem,
                                          0 * fem,
                                          7 * fem),
                                      child: Text(
                                        license_status_label,
                                        style: SafeGoogleFont(
                                          'Inria Sans',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.1975 * ffem / fem,
                                          color:
                                          const Color(0xff1c162e),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      // youcantopupviapaypalbankenD (4:3972)
                                      '$license_Active_status > $license_Expiry_status',
                                      style: SafeGoogleFont(
                                        'Inria Sans',
                                        fontSize: 15 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.1975 * ffem / fem,
                                        letterSpacing: 0.15 * fem,
                                        color: Color(0xffc6c4ca),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // component7iconspluscircleNTK (4:3973)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                width: 26.67 * fem,
                                height: 26.67 * fem,
                                child: Image.asset(
                                  add_icon,
                                  width: 26.67 * fem,
                                  height: 26.67 * fem,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // autogroup7wqxgyo (CGiYCxtBKRuFmZAVVE7WqX)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 40 * fem),

                          width: double.infinity,
                          height: 178 * fem,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(20 * fem,
                                    0 * fem, 20 * fem, 0 * fem),
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        // cardEEd (4:3974)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem,
                                            0 * fem,
                                            9 * fem,
                                            0 * fem),
                                        padding: EdgeInsets.fromLTRB(
                                            56 * fem,
                                            49 * fem,
                                            54 * fem,
                                            41 * fem),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(
                                              30 * fem),
                                          color: toggleAdd
                                              ? appGold
                                              : appWhite,
                                          boxShadow: toggleAdd
                                              ? [
                                            BoxShadow(
                                              color: const Color(
                                                  0x6bf5a94e),
                                              offset: Offset(
                                                  0 * fem,
                                                  8 * fem),
                                              blurRadius:
                                              10 * fem,
                                            ),
                                          ]
                                              : [
                                            BoxShadow(
                                              color: const Color(
                                                  0x14404040),
                                              offset: Offset(
                                                  0 * fem,
                                                  8 * fem),
                                              blurRadius:
                                              10 * fem,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // arrowupoutside2632AV (I4:3974;10135:6791)
                                              margin:
                                              EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  14 * fem),
                                              width: 40 * fem,
                                              height: 40 * fem,
                                              child: Image.asset(
                                                add_list_icon,
                                                width: 40 * fem,
                                                height: 40 * fem,
                                              ),
                                            ),
                                            Text(
                                              // transfertyP (I4:3974;10075:8472)
                                              add_collectors_label,
                                              textAlign:
                                              TextAlign.center,
                                              style: SafeGoogleFont(
                                                'Inria Sans',
                                                fontSize: 14 * ffem,
                                                fontWeight:
                                                FontWeight.w700,
                                                height:
                                                1.1975 * ffem / fem,
                                                color: toggleAdd
                                                    ? appWhite
                                                    : appDark,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          toggleStations = false;
                                          toggleAdd = true;
                                          toggleList = false;
                                          toggleStatistics = false;
                                        });
                                        Get.to(() =>
                                        const CollectorFormWidget());
                                      },
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        // cardqtd (4:3975)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem,
                                            0 * fem,
                                            9 * fem,
                                            0 * fem),
                                        padding: EdgeInsets.fromLTRB(
                                            57 * fem,
                                            49 * fem,
                                            55 * fem,
                                            41 * fem),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          //color: const Color(0xffffffff),
                                          borderRadius:
                                          BorderRadius.circular(
                                              30 * fem),
                                          color: toggleList
                                              ? appGold
                                              : appWhite,
                                          boxShadow: toggleList
                                              ? [
                                            BoxShadow(
                                              color: const Color(
                                                  0x6bf5a94e),
                                              offset: Offset(
                                                  0 * fem,
                                                  8 * fem),
                                              blurRadius:
                                              10 * fem,
                                            ),
                                          ]
                                              : [
                                            BoxShadow(
                                              color: const Color(
                                                  0x14404040),
                                              offset: Offset(
                                                  0 * fem,
                                                  8 * fem),
                                              blurRadius:
                                              10 * fem,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // arrowdown272Mc5 (I4:3975;10135:6791)
                                              margin:
                                              EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  14 * fem),
                                              width: 40 * fem,
                                              height: 40 * fem,
                                              child: Image.asset(
                                                list_icon,
                                                width: 40 * fem,
                                                height: 40 * fem,
                                              ),
                                            ),
                                            Text(
                                              // transferroj (I4:3975;10075:8472)
                                              collector_list_label,
                                              textAlign:
                                              TextAlign.center,
                                              style: SafeGoogleFont(
                                                'Inria Sans',
                                                fontSize: 14 * ffem,
                                                fontWeight:
                                                FontWeight.w700,
                                                height:
                                                1.1975 * ffem / fem,
                                                color: toggleList
                                                    ? appWhite
                                                    : appDark,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          toggleStations = false;
                                          toggleAdd = false;
                                          toggleList = true;
                                          toggleStatistics = false;
                                        });
                                        Get.to(() =>
                                        const CollectorListData(
                                            Agent: 'Agents'));
                                      },
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        // cardqtd (4:3975)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem,
                                            0 * fem,
                                            9 * fem,
                                            0 * fem),
                                        padding: EdgeInsets.fromLTRB(
                                            57 * fem,
                                            49 * fem,
                                            55 * fem,
                                            41 * fem),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          //color: const Color(0xffffffff),
                                          borderRadius:
                                          BorderRadius.circular(
                                              30 * fem),
                                          color: toggleStatistics
                                              ? appGold
                                              : appWhite,
                                          boxShadow: toggleStatistics
                                              ? [
                                            BoxShadow(
                                              color: const Color(
                                                  0x6bf5a94e),
                                              offset: Offset(
                                                  0 * fem,
                                                  8 * fem),
                                              blurRadius:
                                              10 * fem,
                                            ),
                                          ]
                                              : [
                                            BoxShadow(
                                              color: const Color(
                                                  0x14404040),
                                              offset: Offset(
                                                  0 * fem,
                                                  8 * fem),
                                              blurRadius:
                                              10 * fem,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // arrowdown272Mc5 (I4:3975;10135:6791)
                                              margin:
                                              EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  14 * fem),
                                              width: 40 * fem,
                                              height: 40 * fem,
                                              child: Image.asset(
                                                transfer_station,
                                                width: 40 * fem,
                                                height: 40 * fem,
                                              ),
                                            ),
                                            Text(
                                              // transferroj (I4:3975;10075:8472)
                                              statistics_label_1,
                                              textAlign:
                                              TextAlign.center,
                                              style: SafeGoogleFont(
                                                'Inria Sans',
                                                fontSize: 14 * ffem,
                                                fontWeight:
                                                FontWeight.w700,
                                                height:
                                                1.1975 * ffem / fem,
                                                color: toggleStatistics
                                                    ? appWhite
                                                    : appDark,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          toggleStations = false;
                                          toggleAdd = false;
                                          toggleList = false;
                                          toggleStatistics = true;
                                        });
                                        Get.to(() =>
                                        const CollectorDataTable());
                                      },
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        // cardqtd (4:3975)
                                        padding: EdgeInsets.fromLTRB(
                                            57 * fem,
                                            49 * fem,
                                            55 * fem,
                                            41 * fem),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          //color: const Color(0xffffffff),
                                          borderRadius:
                                          BorderRadius.circular(
                                              30 * fem),
                                          color: toggleStations
                                              ? appGold
                                              : appWhite,
                                          boxShadow: toggleStations
                                              ? [
                                            BoxShadow(
                                              color: const Color(
                                                  0x6bf5a94e),
                                              offset: Offset(
                                                  0 * fem,
                                                  8 * fem),
                                              blurRadius:
                                              10 * fem,
                                            ),
                                          ]
                                              : [
                                            BoxShadow(
                                              color: const Color(
                                                  0x14404040),
                                              offset: Offset(
                                                  0 * fem,
                                                  8 * fem),
                                              blurRadius:
                                              10 * fem,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // arrowdown272Mc5 (I4:3975;10135:6791)
                                              margin:
                                              EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  14 * fem),
                                              width: 40 * fem,
                                              height: 40 * fem,
                                              child: Image.asset(
                                                statistics_icon,
                                                width: 40 * fem,
                                                height: 40 * fem,
                                              ),
                                            ),
                                            Text(
                                              // transferroj (I4:3975;10075:8472)
                                              transfer_station_label,
                                              textAlign:
                                              TextAlign.center,
                                              style: SafeGoogleFont(
                                                'Inria Sans',
                                                fontSize: 14 * ffem,
                                                fontWeight:
                                                FontWeight.w700,
                                                height:
                                                1.1975 * ffem / fem,
                                                color: toggleStations
                                                    ? appWhite
                                                    : appDark,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          toggleStations = true;
                                          toggleAdd = false;
                                          toggleList = false;
                                          toggleStatistics = false;
                                        });
                                        Get.to(() =>
                                        const TruckListData());
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // group12794dGD (4:4346)
                          margin: EdgeInsets.fromLTRB(
                              20 * fem, 0 * fem, 20 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              20 * fem, 0 * fem, 0 * fem, 0 * fem),
                          width: double.infinity,
                          height: 75 * fem,
                          decoration: BoxDecoration(
                            color: const Color(0xff1c162e),
                            borderRadius:
                            BorderRadius.circular(16 * fem),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x7f7d64ff),
                                offset: Offset(0 * fem, 8 * fem),
                                blurRadius: 10 * fem,
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // targetcompleted90uDj (4:4348)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                child: Text(
                                  'Log Out',
                                  style: SafeGoogleFont(
                                    'Inria Sans',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.7142857143 * ffem / fem,
                                    color: const Color(0xffffffff),
                                  ),
                                ),
                              ),
                              Container(
                                // component8yzH (4:4349)
                                width: 54 * fem,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(8 * fem),
                                  //color: Colors.red,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    AuthenticationRepository.instance
                                        .logout();
                                  },
                                  icon: Icon(
                                    Icons.logout_outlined,
                                    color: appWhite,
                                  ),
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
          ),
        ),
      ),
      
      
      
      // FutureBuilder(
      //   future: controller.getLicensedCollectorData(),
      //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       if (snapshot.hasData) {
      //         LicensedCollectorModel licensedCollectorData =
      //             snapshot.data as LicensedCollectorModel;
      //
      //         //return Center(child: Text(licensedCollectorData.username));
      //         return 
      //       } else if (snapshot.hasError) {
      //         return Center(child: Text(snapshot.error.toString()));
      //       } else {
      //         return const Center(child: Text('Something Went Wrong'));
      //       }
      //     } else {
      //       return const SplashPage();
      //     }
      //   },
      //   //child: Center(child: Text('Okobo'))
      // ),
    );
  }
}
