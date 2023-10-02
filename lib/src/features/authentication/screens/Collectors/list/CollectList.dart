import 'package:collectors/main.dart';
import 'package:collectors/src/constants/image_strings.dart';
import 'package:collectors/src/features/authentication/model/LicensedCollectorsModel.dart';
import 'package:collectors/src/features/authentication/model/profiles_controller.dart';
import 'package:collectors/src/features/authentication/screens/Collectors/profile/profileUpdate.dart';
import 'package:collectors/src/features/authentication/screens/splash_screen/Splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

//final listcollectors = PopulateCollectorModel.listcollectors;
final controller = Get.put(ProfilesController());

class CollectorListData extends StatelessWidget {
  final String Agent;
  const CollectorListData({Key? key, required this.Agent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Scaffold(
      appBar: AppBar(
        // leading: GestureDetector(
        //   child: Transform.scale(
        //     scale: 0.6,
        //     child: Image.asset(
        //       arrow_back,
        //     ),
        //   ),
        //   onTap: () => Get.to(() => LicensedCollector()),
        // ),
        title: Text(
          "Your Collectors",
          style: TextStyle(color: appDark),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appGold,
        foregroundColor: appDark,
      ),
      body: Stack(children: [
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
        Container(
          color: Colors.transparent,
          child: FutureBuilder<List<LicensedCollectorModel>>(
            future: Agent != 'Agents' ? controller.getAllLicensedCollectorData() : controller.getAllLicensedCollectorAgentsData(),
            builder: (context, snapshot) {
              //print(snapshot.data);
              if (snapshot.connectionState == ConnectionState.done) {
                //print("snapshot.data");
                if (snapshot.hasData) {
                  // LicensedCollectorModel licensedCollectorData =snapshot.data as LicensedCollectorModel;
                  // print(licensedCollectorData.email);
                  return ListView.separated(
                    padding: const EdgeInsets.only(right: 20, left: 10),
                    //shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(profile),
                        ),
                        title: Text(
                          snapshot.data![index].username,
                          style: TextStyle(color: appWhite),
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          color: appGold,
                        ),
                        subtitle: Text(
                          'Phone Number: ${snapshot.data![index].phoneNumber}',
                          style: TextStyle(color: appWhite),
                        ),
                        contentPadding:
                            const EdgeInsets.only(top: 10, bottom: 10),
                        onTap: () {
                          Get.to(() => CollectorDetails(
                              id: snapshot.data![index].id ?? '',
                              username: snapshot.data![index].username ?? '',
                              email: snapshot.data![index].email ?? '',
                              county: snapshot.data![index].county ?? '',
                              subCountry:
                                  snapshot.data![index].subCountry ?? '',
                              ward: snapshot.data![index].ward ?? '',
                              license: snapshot.data![index].license ?? '',
                              phoneNumber:
                                  snapshot.data![index].phoneNumber ?? '',
                            Agent: Agent,));
                          //print(snapshot.data);
                        },
                        onLongPress: () {
                          // do something else
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 0.5,
                        indent: 70,
                        endIndent: 0,
                        color: appWhite,
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
              } else {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: appGold,
                    size: 30,
                  ),
                );
              }
            },
          ),
        ),
      ]),
    );
  }
}

class CollectorDetails extends StatelessWidget {
  final String id;
  final String username;
  final String email;
  final String county;
  final String subCountry;
  final String ward;
  final String license;
  final String phoneNumber;
  final String Agent;

  const CollectorDetails(
      {super.key,
      required this.username,
      required this.email,
      required this.county,
      required this.subCountry,
      required this.ward,
      required this.license,
      required this.phoneNumber,
      required this.id,
        required this.Agent});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      appBar: AppBar(
        // leading: GestureDetector(
        //   child: Transform.scale(
        //     scale: 0.6,
        //     child: Image.asset(
        //       arrow_back,
        //     ),
        //   ),
        //   onTap: () => Get.to(() => const CollectorListData()),
        // ),
        title: Text(
          "Collector's Detail",
          style: TextStyle(color: appDark),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appGold,
        foregroundColor: appDark,
      ),
      body: Stack(children: [
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
        Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8), // Border width
                  decoration:
                      BoxDecoration(color: appGold, shape: BoxShape.circle),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(50), // Image radius
                      child: const Image(
                        image: AssetImage(profile),
                        height: 110,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: ListTile.divideTiles(context: context, tiles: [
                    ListTile(
                      title: Text(
                        'Name',
                        style: TextStyle(color: appWhite),
                      ),
                      subtitle: Text(
                        username,
                        style: TextStyle(color: appWhite),
                      ),
                      trailing: Wrap(
                        spacing: -10,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: appGreen,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Get.to(() => ProfileDetailsUpdate(
                                  id: id ?? '',
                                  username: username ?? '',
                                  email: email ?? '',
                                  county: county ?? '',
                                  subCountry: subCountry ?? '',
                                  ward: ward ?? '',
                                  license: license ?? '',
                                  phoneNumber: phoneNumber ?? ''));
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                  'Warning!!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.red),
                                ),
                                content: Text(
                                  'Are you sure you want to delete \n\n$username\n$license',
                                  textAlign: TextAlign.center,
                                ),
                                actions: <Widget>[
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                          child: Container(
                                            color: appGold,
                                            child: TextButton(
                                              // style: TextButton.styleFrom(
                                              //   primary: Colors.purpleAccent, // Text Color
                                              // ),
                                              onPressed: () {
                                                Navigator.pop(
                                                    context, 'Cancel');
                                              },
                                              child: Text(
                                                'Cancel',
                                                style:
                                                    TextStyle(color: appWhite),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Get.to(() => CollectorListData(Agent: Agent));
                                          },
                                          //Navigator.pop(context, 'Yes'),
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(color: appGold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        //print('goat');
                      },
                    ),
                    Divider(
                      height: 1.5,
                      color: appWhite,
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      title: Text(
                        'County',
                        style: TextStyle(color: appWhite),
                      ),
                      subtitle: Text(
                        county,
                        style: TextStyle(color: appWhite),
                      ),
                      trailing: Icon(
                        Icons.map,
                        color: appGold,
                      ),
                      onTap: () {
                        //print('goat');
                      },
                    ),
                    Divider(
                      height: 1.5,
                      color: appWhite,
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      title: Text(
                        'Sub-County',
                        style: TextStyle(color: appWhite),
                      ),
                      subtitle: Text(
                        subCountry,
                        style: TextStyle(color: appWhite),
                      ),
                      trailing: Icon(
                        Icons.share_location,
                        color: appGold,
                      ),
                      onTap: () {
                        //print('goat');
                      },
                    ),
                    Divider(
                      height: 1.5,
                      color: appWhite,
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      title: Text(
                        'Ward',
                        style: TextStyle(color: appWhite),
                      ),
                      subtitle: Text(
                        ward,
                        style: TextStyle(color: appWhite),
                      ),
                      trailing: Icon(
                        Icons.location_on,
                        color: appGold,
                      ),
                      onTap: () {
                        //print('goat');
                      },
                    ),
                    Divider(
                      height: 1.5,
                      color: appWhite,
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      title: Text(
                        'Phone Number',
                        style: TextStyle(color: appWhite),
                      ),
                      subtitle: Text(
                        phoneNumber,
                        style: TextStyle(color: appWhite),
                      ),
                      trailing: Icon(
                        Icons.settings_phone,
                        color: appGold,
                      ),
                      onTap: () {
                        //print('goat');
                      },
                    ),
                    Divider(
                      height: 1.5,
                      color: appWhite,
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      title: Text(
                        'Unique Identifier',
                        style: TextStyle(color: appWhite),
                      ),
                      subtitle: Text(
                        license,
                        style: TextStyle(color: appWhite),
                      ),
                      trailing: Icon(
                        Icons.local_activity,
                        color: appGold,
                      ),
                      onTap: () {
                        //print('goat');
                      },
                    ),
                  ]).toList(),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
