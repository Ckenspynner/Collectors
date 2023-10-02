import 'package:collectors/src/constants/image_strings.dart';
import 'package:collectors/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';

class CollectorsProfile extends StatelessWidget {
  const CollectorsProfile({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return
      SizedBox(
      width: double.infinity,
      child: Container(
        // overviewRhb (4:3102)
        padding: EdgeInsets.fromLTRB(0*fem, 14*fem, 0*fem, 0*fem),
        width: double.infinity,
        decoration: const BoxDecoration (
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // group12713wrH (4:3103)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 20*fem),
              padding: EdgeInsets.fromLTRB(23.67*fem, 10*fem, 23.67*fem, 10*fem),
              width: double.infinity,
              decoration: const BoxDecoration (
                color: Color(0xffffffff),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // component7iconsarrowleftRWZ (I4:3103;10261:60)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 20.67*fem, 0*fem),
                    width: 14.67*fem,
                    height: 14.67*fem,
                    child: Image.asset(
                      'REPLACE_IMAGE:I4:3103;10261:60',
                      width: 14.67*fem,
                      height: 14.67*fem,
                    ),
                  ),
                  Container(
                    // welcomejone8vm (I4:3103;10261:1)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 206.67*fem, 0*fem),
                    child: Text(
                      'Over View',
                      style: SafeGoogleFont (
                        'Inria Sans',
                        fontSize: 16*ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.5*ffem/fem,
                        letterSpacing: 0.16*fem,
                        color: Color(0xff1c162e),
                      ),
                    ),
                  ),
                  Container(
                    // component7iconsdice43j (I4:3103;10261:2)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                    width: 14.67*fem,
                    height: 14.67*fem,
                    child: Image.asset(
                      'REPLACE_IMAGE:I4:3103;10261:2',
                      width: 14.67*fem,
                      height: 14.67*fem,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // hijonexQ1 (4:3105)
              margin: EdgeInsets.fromLTRB(20*fem, 0*fem, 0*fem, 6*fem),
              child: Text(
                'Hi, Purity!',
                style: SafeGoogleFont (
                  'Inria Sans',
                  fontSize: 26*ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.8461538462*ffem/fem,
                  letterSpacing: 0.26*fem,
                  color: Color(0xff1c162e),
                ),
              ),
            ),
            Container(
              // whatwillyoudotoday3gM (4:3107)
              margin: EdgeInsets.fromLTRB(20*fem, 0*fem, 0*fem, 0*fem),
              child: Text(
                'Collection records and updates',
                style: SafeGoogleFont (
                  'Inria Sans',
                  fontSize: 15*ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.1975*ffem/fem,
                  letterSpacing: 0.15*fem,
                  color: Color(0xffc6c4ca),
                ),
              ),
            ),
            Container(
              // autogroup2zxf9UV (CGiGta58ayzBN6oaui2ZXF)
              padding: EdgeInsets.fromLTRB(20*fem, 40*fem, 20*fem, 65*fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // autogroupccz5oxM (CGiECUtYo34uURMAt3Ccz5)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 25*fem),
                    width: double.infinity,
                    height: 158*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // cardtokenbonus7y3 (4:3109)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 25*fem, 0*fem),
                          padding: EdgeInsets.fromLTRB(13*fem, 15*fem, 14*fem, 20*fem),
                          width: 155*fem,
                          height: double.infinity,
                          decoration: BoxDecoration (
                            color: Color(0xff1c162e),
                            borderRadius: BorderRadius.circular(12*fem),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x7f7d64ff),
                                offset: Offset(0*fem, 8*fem),
                                blurRadius: 10*fem,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // autogroupktjooay (CGiETUTZsdonGjVu3ykTjo)
                                margin: EdgeInsets.fromLTRB(3*fem, 0*fem, 0.95*fem, 18*fem),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // dashboardixq (4:3110)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 45.05*fem, 0*fem),
                                      child: Text(
                                        'Collections',
                                        style: SafeGoogleFont (
                                          'Inria Sans',
                                          fontSize: 14*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.1975*ffem/fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // arrowdown338S89 (4:3111)
                                      margin: EdgeInsets.fromLTRB(0*fem, 3*fem, 0*fem, 0*fem),
                                      width: 12*fem,
                                      height: 6.6*fem,
                                      child: Image.asset(
                                        down_arrow,
                                        width: 12*fem,
                                        height: 6.6*fem,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // autogroupznn5kuX (CGiEaDmKroe5LB4pq3znn5)
                                margin: EdgeInsets.fromLTRB(6*fem, 0*fem, 5*fem, 7*fem),
                                width: double.infinity,
                                height: 67*fem,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      // autogroupzvrbVcD (CGiEjYq7eCYXnQwNDzZVRb)
                                      padding: EdgeInsets.fromLTRB(0*fem, 22*fem, 23*fem, 0*fem),
                                      height: double.infinity,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            // rectangle477nrD (4:3117)
                                            width: 5*fem,
                                            height: 22*fem,
                                            decoration: BoxDecoration (
                                              borderRadius: BorderRadius.circular(8*fem),
                                              color: Color(0xffffd035),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 23*fem,
                                          ),
                                          Container(
                                            // rectangle479J3s (4:3118)
                                            width: 5*fem,
                                            height: 36*fem,
                                            decoration: BoxDecoration (
                                              borderRadius: BorderRadius.circular(8*fem),
                                              color: Color(0xffffd035),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 23*fem,
                                          ),
                                          Container(
                                            // rectangle481SA5 (4:3119)
                                            width: 5*fem,
                                            height: 45*fem,
                                            decoration: BoxDecoration (
                                              borderRadius: BorderRadius.circular(8*fem),
                                              color: Color(0xffffd035),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // rectangle4836VX (4:3120)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 23*fem, 0*fem),
                                      width: 5*fem,
                                      height: 67*fem,
                                      decoration: BoxDecoration (
                                        borderRadius: BorderRadius.circular(8*fem),
                                        color: Color(0xffffd035),
                                      ),
                                    ),
                                    Container(
                                      // rectangle4852PB (4:3121)
                                      width: 5*fem,
                                      height: 51*fem,
                                      decoration: BoxDecoration (
                                        borderRadius: BorderRadius.circular(8*fem),
                                        color: Color(0xffffd035),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // autogroupmnfbmrZ (CGiEuDDgZRuicJbDK7Mnfb)
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // margTj (4:3112)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 12*fem, 0*fem),
                                      child: Text(
                                        'Mar',
                                        style: SafeGoogleFont (
                                          'Dosis',
                                          fontSize: 11*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.265*ffem/fem,
                                          letterSpacing: 0.11*fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // aprb4u (4:3113)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 11*fem, 0*fem),
                                      child: Text(
                                        'Apr',
                                        style: SafeGoogleFont (
                                          'Dosis',
                                          fontSize: 11*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.265*ffem/fem,
                                          letterSpacing: 0.11*fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // mayi9X (4:3114)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 10*fem, 0*fem),
                                      child: Text(
                                        'May',
                                        style: SafeGoogleFont (
                                          'Dosis',
                                          fontSize: 11*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.265*ffem/fem,
                                          letterSpacing: 0.11*fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // junqjw (4:3115)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 12*fem, 0*fem),
                                      child: Text(
                                        'Jun',
                                        style: SafeGoogleFont (
                                          'Dosis',
                                          fontSize: 11*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.265*ffem/fem,
                                          letterSpacing: 0.11*fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      // julyLM (4:3116)
                                      'Jul',
                                      style: SafeGoogleFont (
                                        'Dosis',
                                        fontSize: 11*ffem,
                                        fontWeight: FontWeight.w500,
                                        height: 1.265*ffem/fem,
                                        letterSpacing: 0.11*fem,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // cardtokenbonus5eH (4:3131)
                          padding: EdgeInsets.fromLTRB(16*fem, 15*fem, 15.34*fem, 18*fem),
                          width: 155*fem,
                          height: double.infinity,
                          decoration: BoxDecoration (
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(12*fem),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x14404040),
                                offset: Offset(0*fem, 8*fem),
                                blurRadius: 10*fem,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // autogroupsudjRLm (CGiFMXoAESKS6mJK33sudj)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 41*fem),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // invoicektq (4:3132)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 66.97*fem, 0*fem),
                                      child: Text(
                                        'Houses',
                                        style: SafeGoogleFont (
                                          'Inria Sans',
                                          fontSize: 14*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.4285714286*ffem/fem,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // arrowdown338U49 (4:3135)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                                      width: 11.68*fem,
                                      height: 6.6*fem,
                                      child: Image.asset(
                                        down_arrow,
                                        width: 11.68*fem,
                                        height: 6.6*fem,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                // Bz9 (4:3134)
                                '16',
                                style: SafeGoogleFont (
                                  'Inria Sans',
                                  fontSize: 26*ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.8461538462*ffem/fem,
                                  letterSpacing: 0.26*fem,
                                  color: Color(0xff1c162e),
                                ),
                              ),
                              Text(
                                // projectandinvoice8uP (4:3133)
                                'Total houses visited',
                                style: SafeGoogleFont (
                                  'Inria Sans',
                                  fontSize: 12*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3333333333*ffem/fem,
                                  letterSpacing: 0.12*fem,
                                  color: Color(0xff1c162e),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    // autogroupbrrygAD (CGiFUwkUVH5BuWRrCUbRry)
                    width: double.infinity,
                    height: 158*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // cardtokenbonusdbF (4:3122)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 25*fem, 0*fem),
                          padding: EdgeInsets.fromLTRB(16*fem, 16*fem, 14.95*fem, 16*fem),
                          width: 155*fem,
                          height: double.infinity,
                          decoration: BoxDecoration (
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(12*fem),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x14404040),
                                offset: Offset(0*fem, 8*fem),
                                blurRadius: 10*fem,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // autogroupsudjRLm (CGiFMXoAESKS6mJK33sudj)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 41*fem),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // invoicektq (4:3132)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 66.97*fem, 0*fem),
                                      child: Text(
                                        'Wet',
                                        style: SafeGoogleFont (
                                          'Inria Sans',
                                          fontSize: 14*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.4285714286*ffem/fem,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // arrowdown338U49 (4:3135)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                                      width: 11.68*fem,
                                      height: 6.6*fem,
                                      child: Image.asset(
                                        down_arrow,
                                        width: 11.68*fem,
                                        height: 6.6*fem,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                // Bz9 (4:3134)
                                '657kgs',
                                style: SafeGoogleFont (
                                  'Inria Sans',
                                  fontSize: 26*ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.8461538462*ffem/fem,
                                  letterSpacing: 0.26*fem,
                                  color: Color(0xff1c162e),
                                ),
                              ),
                              Text(
                                // projectandinvoice8uP (4:3133)
                                'Total Wet Weight',
                                style: SafeGoogleFont (
                                  'Inria Sans',
                                  fontSize: 12*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3333333333*ffem/fem,
                                  letterSpacing: 0.12*fem,
                                  color: Color(0xff1c162e),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // cardtokenbonus5eH (4:3131)
                          padding: EdgeInsets.fromLTRB(16*fem, 15*fem, 15.34*fem, 18*fem),
                          width: 155*fem,
                          height: double.infinity,
                          decoration: BoxDecoration (
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(12*fem),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x14404040),
                                offset: Offset(0*fem, 8*fem),
                                blurRadius: 10*fem,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // autogroupsudjRLm (CGiFMXoAESKS6mJK33sudj)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 41*fem),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // invoicektq (4:3132)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 66.97*fem, 0*fem),
                                      child: Text(
                                        'Dry',
                                        style: SafeGoogleFont (
                                          'Inria Sans',
                                          fontSize: 14*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.4285714286*ffem/fem,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // arrowdown338U49 (4:3135)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                                      width: 11.68*fem,
                                      height: 6.6*fem,
                                      child: Image.asset(
                                        down_arrow,
                                        width: 11.68*fem,
                                        height: 6.6*fem,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                // Bz9 (4:3134)
                                '800kgs',
                                style: SafeGoogleFont (
                                  'Inria Sans',
                                  fontSize: 26*ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.8461538462*ffem/fem,
                                  letterSpacing: 0.26*fem,
                                  color: Color(0xff1c162e),
                                ),
                              ),
                              Text(
                                // projectandinvoice8uP (4:3133)
                                'Total Dry Weight',
                                style: SafeGoogleFont (
                                  'Inria Sans',
                                  fontSize: 12*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3333333333*ffem/fem,
                                  letterSpacing: 0.12*fem,
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
            // SizedBox(
            //   // autogroupqyc9SkH (CGiGbFEfZY2BxEBitXqYc9)
            //   width: double.infinity,
            //   height: 88*fem,
            //   child: Stack(
            //     children: [
            //       Positioned(
            //         // lineoaq (I4:3106;143:612)
            //         left: 120*fem,
            //         top: 75*fem,
            //         child: Align(
            //           child: SizedBox(
            //             width: 135*fem,
            //             height: 5*fem,
            //             child: Container(
            //               decoration: BoxDecoration (
            //                 borderRadius: BorderRadius.circular(100*fem),
            //                 color: Color(0xff000000),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Positioned(
            //         // tabbarhw7 (4:3160)
            //         left: 0*fem,
            //         top: 0*fem,
            //         child: Container(
            //           padding: EdgeInsets.fromLTRB(28*fem, 14*fem, 28*fem, 8*fem),
            //           width: 375*fem,
            //           height: 88*fem,
            //           decoration: BoxDecoration (
            //             color: Color(0xfffdfdfd),
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Color(0x19000000),
            //                 offset: Offset(0*fem, 4*fem),
            //                 blurRadius: 10*fem,
            //               ),
            //             ],
            //           ),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               Container(
            //                 // frame41oDT (I4:3160;10082:11961)
            //                 margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 21*fem),
            //                 width: double.infinity,
            //                 height: 40*fem,
            //                 child: Row(
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   children: [
            //                     Container(
            //                       // tabmainibK (I4:3160;10082:11962)
            //                       padding: EdgeInsets.fromLTRB(20.83*fem, 12*fem, 17.5*fem, 12*fem),
            //                       height: double.infinity,
            //                       decoration: BoxDecoration (
            //                         borderRadius: BorderRadius.circular(15*fem),
            //                         gradient: LinearGradient (
            //                           begin: Alignment(-1, 0),
            //                           end: Alignment(1, 0),
            //                           colors: <Color>[Color(0xff9d70ff), Color(0xff7460ff)],
            //                           stops: <double>[0, 1],
            //                         ),
            //                       ),
            //                       child: Row(
            //                         crossAxisAlignment: CrossAxisAlignment.center,
            //                         children: [
            //                           Container(
            //                             // navigationb9K (I4:3160;10082:11962;10098:1743)
            //                             margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7.33*fem, 0*fem),
            //                             width: 13.33*fem,
            //                             height: 12.7*fem,
            //                             child: Image.asset(
            //                               'REPLACE_IMAGE:I4:3160;10082:11962;10098:1743',
            //                               width: 13.33*fem,
            //                               height: 12.7*fem,
            //                             ),
            //                           ),
            //                           Text(
            //                             // homeiUq (I4:3160;10082:11962;10082:9536)
            //                             'Home',
            //                             style: SafeGoogleFont (
            //                               'Inria Sans',
            //                               fontSize: 11*ffem,
            //                               fontWeight: FontWeight.w700,
            //                               height: 1.4545454545*ffem/fem,
            //                               color: Color(0xffffffff),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       width: 33*fem,
            //                     ),
            //                     Container(
            //                       // tabextrarL9 (I4:3160;10082:11963)
            //                       width: 44*fem,
            //                       height: 40*fem,
            //                       child: Image.asset(
            //                         'REPLACE_IMAGE:I4:3160;10082:11963',
            //                         width: 44*fem,
            //                         height: 40*fem,
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       width: 33*fem,
            //                     ),
            //                     Container(
            //                       // tabextraxPB (I4:3160;10082:11939)
            //                       width: 44*fem,
            //                       height: 40*fem,
            //                       child: Image.asset(
            //                         'REPLACE_IMAGE:I4:3160;10082:11939',
            //                         width: 44*fem,
            //                         height: 40*fem,
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       width: 33*fem,
            //                     ),
            //                     Container(
            //                       // tabextraF7P (I4:3160;10082:11950)
            //                       width: 44*fem,
            //                       height: 40*fem,
            //                       child: Image.asset(
            //                         'REPLACE_IMAGE:I4:3160;10082:11950',
            //                         width: 44*fem,
            //                         height: 40*fem,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               Container(
            //                 // linezKs (I4:3160;10098:7860;143:612)
            //                 margin: EdgeInsets.fromLTRB(92*fem, 0*fem, 92*fem, 0*fem),
            //                 width: double.infinity,
            //                 height: 5*fem,
            //                 decoration: BoxDecoration (
            //                   borderRadius: BorderRadius.circular(100*fem),
            //                   color: Color(0xff000000),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}