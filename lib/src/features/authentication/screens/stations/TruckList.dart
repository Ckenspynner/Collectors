import 'dart:ui';
import 'package:collectors/main.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:collectors/src/features/authentication/screens/models/populatetrucklistdata.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


final listTrucks = PopulateTruckModel.listTrucks;

class TruckListData extends StatelessWidget {
  const TruckListData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Trucks and Stations",
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appGold,
        foregroundColor: appDark,
      ),
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
          ListView.separated(
            padding: const EdgeInsets.only(right: 20, left: 10),
            itemCount: listTrucks.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(listTrucks[index].pictures),
                ),
                title: Text(listTrucks[index].model,style: TextStyle(color: appWhite),),
                trailing: Icon(Icons.keyboard_arrow_right,color: appGold,),
                subtitle: Text('Tag Number: ${listTrucks[index].plateNo}',style: TextStyle(color: appWhite),),
                contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
                onTap: () {
                  Get.to(() =>  TruckDetails(heroTag: index));
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
          ),
        ]
      ),
    );
  }
}

class TruckDetails extends StatelessWidget {
  final int heroTag;

  const TruckDetails({super.key, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Details",
        ),
        centerTitle: true,
        elevation: 0,
        foregroundColor: appDark,
        backgroundColor: appGold,
      ),
      body: Stack(
        children:[
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
                  decoration: BoxDecoration(
                      color: appGold, shape: BoxShape.circle),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(50), // Image radius
                      child: Image(
                        image: AssetImage(listTrucks[heroTag].pictures),
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
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: ListTile.divideTiles(context: context, tiles: [
                  ListTile(
                    title: Text('Model',style: TextStyle(color: appWhite),),
                    subtitle: Text(listTrucks[heroTag].model,style: TextStyle(color: appWhite),),
                    trailing: Icon(Icons.edit,color: appGold,),
                    onTap: () {
                      //print('goat');
                    },
                  ),
                  Divider(height: 1.5,color: appWhite,indent: 20,endIndent: 20,),
                  ListTile(
                    title: Text('Tag Number',style: TextStyle(color: appWhite),),
                    subtitle: Text(listTrucks[heroTag].plateNo,style: TextStyle(color: appWhite),),
                    trailing: Icon(Icons.loyalty,color: appGold,),
                    onTap: () {
                      //print('goat');
                    },
                  ),
                  Divider(height: 1.5,color: appWhite,indent: 20,endIndent: 20,),
                  ListTile(
                    title: Text('Operator',style: TextStyle(color: appWhite),),
                    subtitle: Text(listTrucks[heroTag].driver,style: TextStyle(color: appWhite),),
                    trailing: Icon(Icons.local_shipping,color: appGold,),
                    onTap: () {
                      //print('goat');
                    },
                  ),
                  Divider(height: 1.5,color: appWhite,indent: 20,endIndent: 20,),
                  ListTile(
                    title: Text('Operator Contact',style: TextStyle(color: appWhite),),
                    subtitle: Text(listTrucks[heroTag].driverContact,style: TextStyle(color: appWhite),),
                    trailing: Icon(Icons.settings_phone,color: appGold,),
                    onTap: () {
                      //print('goat');
                    },
                  ),
                  Divider(height: 1.5,color: appWhite,indent: 20,endIndent: 20,),
                  ListTile(
                    title: Text('Capacity',style: TextStyle(color: appWhite),),
                    subtitle: Text(listTrucks[heroTag].tonnageCapacity,style: TextStyle(color: appWhite),),
                    trailing: Icon(Icons.money,color: appGold,),
                    onTap: () {
                      //print('goat');
                    },
                  ),

                  ListTile(
                    subtitle: TextButton(
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Send Request'),
                          content: const Text(
                              'Are you sure you want to send a collection request'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'Yes');
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  confirmBtnColor: Colors.teal,
                                  animType: CoolAlertAnimType.slideInLeft,
                                  //autoCloseDuration: const Duration(seconds: 5),
                                  text: "Request Sent Successfully",
                                );
                              },
                              //Navigator.pop(context, 'Yes'),
                              child: const Text('Yes'),
                            ),
                          ],
                        ),
                      ),
                      child: Text('Send Collection Request',style: TextStyle(color: appGreen),),
                    ),
                  ),
                ]).toList(),
              ),
            ),
          ],
        ),
        ]
      ),
    );
  }
}
