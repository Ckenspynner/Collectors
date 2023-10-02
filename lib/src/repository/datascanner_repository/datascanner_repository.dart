import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collectors/src/features/authentication/model/LicensedCollectorsModel.dart';
import 'package:collectors/src/features/authentication/model/dataScannerModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

/*
*  Step-2 Create A Repository to perform Databases Operation
* */


class DataScannerRepository extends GetxController {
  static DataScannerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  ///Stores Scannered Data
  storeDataScanner(DataScannerModel dataScannerModel) async {
    await _db.collection("AgentScannerCollections")
        .add(dataScannerModel.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Saved Successfully.",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    });
  }

  ///Stores Scannered Data
  storeDriverDataScanner(DataScannerModel dataScannerModel) async {
    await _db.collection("DriverScannerCollections")
        .add(dataScannerModel.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Saved Successfully.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green),
    )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    });
  }

  ///Stores Scannered Data
  storeStationDataScanner(DataScannerModel dataScannerModel) async {
    await _db.collection("StationScannerCollections")
        .add(dataScannerModel.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Saved Successfully.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green),
    )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    });
  }

  ///Fetch ALL Scanner Collected Data
  Future<List<DataScannerModel>> allDataScannerDetails() async {
    final snapshot = await _db.collection("AgentScannerCollections").get();
    final dataScannerData = snapshot.docs.map((e) => DataScannerModel.fromSnapshot(e)).toList();
    return dataScannerData;
  }

  ///Fetch Licensed Collector Agent Dashboard Data
  Future<DataScannerModel> getLicensedCollectorAgentData9(String email) async {
    final snapshot = await _db.collection("AgentScannerCollections").get();
    final licensedCollectorData = snapshot.docs.map((e) => DataScannerModel.fromSnapshot(e)).single;
    return licensedCollectorData;
  }

}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:collectors/main.dart';
// import 'package:collectors/src/constants/image_strings.dart';
// import 'package:collectors/src/features/authentication/controllers/dataScanner_controller.dart';
// import 'package:collectors/src/features/authentication/model/LicensedCollectorsModel.dart';
// import 'package:collectors/src/features/authentication/model/dataScannerModel.dart';
// import 'package:collectors/src/features/authentication/screens/Collectors/list/CollectList.dart';
// import 'package:collectors/src/features/authentication/screens/models/populatedailycollectionslistdata.dart';
// import 'package:collectors/src/features/authentication/screens/splash_screen/Splashscreen.dart';
// import 'package:collectors/src/repository/authentication_repository/authentication_repository.dart';
// import 'package:collectors/src/utils/utils.dart';
// import 'package:cool_alert/cool_alert.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:qr_flutter/qr_flutter.dart';
//
// final listDailyCollections = PopulateCollectionsHouse.listDailyCollections;
// String currentDate = DateFormat('d/M/yyyy').format(DateTime.now());
// String currentDate1 = DateFormat('d/M/yyyy').format(
//   DateTime.now().subtract(const Duration(days: 1)),
// );
// String currentDate2 = DateFormat('d/M/yyyy').format(
//   DateTime.now().subtract(const Duration(days: 2)),
// );
// double wettotal = 0.0;
// double drytotal = 0.0;
// bool _visible = true;
// var option = "Today's";
//
// List<Map<String, dynamic>> results = [];
//
// class GeneralCollector extends StatefulWidget {
//   final bool backNav;
//   final String collectorName;
//
//   const GeneralCollector(
//       {Key? key,
//         this.restorationId,
//         required this.backNav,
//         required this.collectorName})
//       : super(key: key);
//   final String? restorationId;
//
//   @override
//   State<GeneralCollector> createState() => _GeneralCollectorState();
// }
//
// class _GeneralCollectorState extends State<GeneralCollector>
//     with RestorationMixin {
//   // In this example, the restoration ID for the mixin is passed in through
//   // the [StatefulWidget]'s constructor.
//   @override
//   String? get restorationId => widget.restorationId;
//
//   final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
//   late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
//   RestorableRouteFuture<DateTime?>(
//     onComplete: _selectDate,
//     onPresent: (NavigatorState navigator, Object? arguments) {
//       return navigator.restorablePush(
//         _datePickerRoute,
//         arguments: _selectedDate.value.millisecondsSinceEpoch,
//       );
//     },
//   );
//
//   @pragma('vm:entry-point')
//   static Route<DateTime> _datePickerRoute(
//       BuildContext context,
//       Object? arguments,
//       ) {
//     return DialogRoute<DateTime>(
//       context: context,
//       builder: (BuildContext context) {
//         return DatePickerDialog(
//           restorationId: 'date_picker_dialog',
//           initialEntryMode: DatePickerEntryMode.calendarOnly,
//           initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
//           firstDate: DateTime(2021),
//           lastDate: DateTime(2024),
//         );
//       },
//     );
//   }
//
//   @override
//   void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
//     registerForRestoration(_selectedDate, 'selected_date');
//     registerForRestoration(
//         _restorableDatePickerRouteFuture, 'date_picker_route_future');
//   }
//
//   void _selectDate(DateTime? newSelectedDate) {
//     if (newSelectedDate != null) {
//       setState(() {
//         _selectedDate.value = newSelectedDate;
//         option =
//         '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
//         _runFilter(option);
//       });
//     } else {
//       _runFilter(currentDate);
//       option = "Today's";
//     }
//   }
//
//   // This holds a list of fiction users
//   // You can use data fetched from a database or a server as well
//   // final List<Map<String, dynamic>> _allUsers = [
//   //   {"house": "HSE01", "dates": currentDate, "wet": 29, "dry": 9},
//   //   {"house": "HSE02", "dates": currentDate1, "wet": 40, "dry": 20},
//   //   {"house": "HSE03", "dates": currentDate2, "wet": 5, "dry": 2},
//   //   {"house": "HSE04", "dates": currentDate, "wet": 35, "dry": 25},
//   //   {"house": "HSE05", "dates": currentDate1, "wet": 21, "dry": 29},
//   //   {"house": "HSE06", "dates": currentDate2, "wet": 55, "dry": 29},
//   //   {"house": "HSE07", "dates": currentDate, "wet": 30, "dry": 21},
//   //   {"house": "HSE08", "dates": currentDate1, "wet": 14, "dry": 39},
//   //   {"house": "HSE09", "dates": currentDate2, "wet": 100, "dry": 29},
//   //   {"house": "HSE10", "dates": currentDate, "wet": 32, "dry": 29},
//   // ];
//
//   final List<Map<String, dynamic>> _allUsers = [
//       {SupervisorIdentity: lachrispineotieno702@gmail.com, Enumerator: Catherine Mwalugha, Segregation: Not Segregated, Wet: 0 Kgs, SourceName: HSE03, Dry: 0 Kgs, CurrentDate: 16/9/2023},
// {SupervisorIdentity: lachrispineotieno702@gmail.com, Enumerator: Catherine Mwalugha, Segregation: Segregated, Wet: 90 Kgs, SourceName: HSE02, Dry: 120 Kgs, CurrentDate: 16/9/2023},
// {SupervisorIdentity: lachrispineotieno702@gmail.com, Enumerator: Catherine Mwalugha, Segregation: Segregated, Wet: 59 Kgs, SourceName: HSE01, Dry: 74 Kgs, CurrentDate: 16/9/2023},
// {SupervisorIdentity: lachrispineotieno702@gmail.com, Segregation: Not Segregated, Enumerator: Catherine Mwalugha, Wet: 0 Kgs, SourceName: HSE04, Dry: 0 Kgs, CurrentDate: 16/9/2023}];
//
// final CollectionReference _collectionRef = FirebaseFirestore.instance.collection('AgentScannerCollections');
//
// Future<void> getScannedCollectedData() async {
//   // Get docs from collection reference
//   QuerySnapshot querySnapshot = await _collectionRef.get();
//
//   // Get data from docs and convert map to List
//   final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
//
//   print(allData);
// }
//
// // This list holds the data for the list view
// List<Map<String, dynamic>> _foundUsers = [];
//
// // This function is called whenever the text field changes
// void _runFilter(String enteredKeyword) {
//   if (enteredKeyword.isEmpty) {
//     // if the search field is empty or only contains white-space, we'll display all users
//     results = _allUsers;
//     //print(results);
//   } else {
//     results = _allUsers
//         .where((user) => user["dates"].toLowerCase() == enteredKeyword)
//         .toList();
//     // we use the toLowerCase() method to make it case-insensitive
//
//     //Calculates wet weight
//     wettotal = results.fold(0, (sum, item) => sum + item["wet"]);
//
//     //Calculates dry weight
//     drytotal = results.fold(0, (sum, item) => sum + item["dry"]);
//
//     //if(results == []){_toggle();}else{_visible = true;}
//     //print(results);
//     //print('Total Dry $wettotal, Total DRY $drytotal');
//   }
//
//   // Refresh the UI
//   setState(() {
//     _foundUsers = results;
//     if (results.isEmpty) {
//       _visible = false;
//     } else {
//       _visible = true;
//     }
//     if (option == currentDate) {
//       option = "Today's";
//     }
//   });
// }
//
// //////////////////////////////////////////////////////////////////////////////
//
// String _scanBarcode = 'Unknown';
// String substring = "QR@KMFRI";
// late String valueName = '',
//     valueCounty = '',
//     valueGPS = '',
//     valuePhone = '',
//     valueHouse = '';
// late Map<int, String> values;
// late TextEditingController controllerDialog;
// late String _scanNoteMessage = "Press the to right icon to scan QR code";
// String weightDryWaste = 'Click To Add Weight',
//     weightWetWaste = 'Click To Add Weight';
// bool _visibleScanner = false;
// bool _visibleWetDryOnList = true;
//
// @override
// void initState() {
//   _runFilter(currentDate);
//   getScannedCollectedData();
//   super.initState();
//
//   controllerDialog = TextEditingController();
// }
//
// Future<void> scanQR() async {
//   String barcodeScanRes;
//   try {
//     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666', 'Cancel', true, ScanMode.QR);
//   } on PlatformException {
//     barcodeScanRes = 'Failed to get platform version.';
//   }
// //barcode scanner flutter ant
//   setState(() {
//     _scanBarcode = barcodeScanRes;
//
//     //Checks for incomplete QR CODE scan
//     if (_scanBarcode == '-1') {
//       _scanNoteMessage = "Press the to right icon to scan QR code";
//       valueName = '';
//       valueCounty = '';
//       valueGPS = '';
//       valuePhone = '';
//       valueHouse = '';
//       _visibleScanner = false;
//     } else {
//       //Checks for the SECRET KEY in the QR CODE
//       if (_scanBarcode.contains(substring)) {
//         //Splits the QR Value to array of strings
//         final split = _scanBarcode.split(',');
//         //Checks if the QR value contains more than 6 parameters
//         if (split.length > 7) {
//           _scanNoteMessage =
//           "INVALID\n\nThe QR CODE contains too many parameters";
//           valueName = '';
//           valueCounty = '';
//           valueGPS = '';
//           valuePhone = '';
//           valueHouse = '';
//           _visibleScanner = false;
//         } else {
//           values = {for (int i = 0; i < split.length; i++) i: split[i]};
//           //print(values);
//
//           _scanNoteMessage = '';
//           _visibleScanner = true;
//
//           valueHouse = '${values[0]}';
//           valueName = '${values[1]}';
//           valueCounty = '${values[2]}';
//           valueGPS = '${values[3]} , ${values[4]}';
//           valuePhone = '${values[5]}';
//
//           //print('$valueHouse, $valueName, $valueCounty, $valueGPS, $valuePhone');
//         }
//       } else {
//         _scanNoteMessage =
//         "INVALID\n\nThe QR CODE does not meet all the standards";
//         valueName = '';
//         valueCounty = '';
//         valueGPS = '';
//         valuePhone = '';
//         valueHouse = '';
//         _visibleScanner = false;
//       }
//     }
//   });
// }
//
// //Hides widgets
// void _toggle() {
//   scanQR();
//   setState(() {
//     _scanNoteMessage = '';
//     _visibleScanner = !_visibleScanner;
//   });
// }
//
// @override
// void dispose() {
//   controllerDialog.dispose();
//   super.dispose();
// }
//
// //////////////////////////////////////////////////////////////////////////////
//
// bool _toggleStatistics = true;
// bool _toggleQR_Scanner = false;
// bool _toggleQR = false;
// var splitName;
//
// Future<String?> openDialog() => showDialog<String>(
//     context: context,
//     builder: (builder) => AlertDialog(
//       title: const Text('Weight in Kgs'),
//       content: TextField(
//         autofocus: true,
//         decoration:
//         const InputDecoration(hintText: 'Enter weight in Kgs'),
//         keyboardType: TextInputType.number,
//         inputFormatters: <TextInputFormatter>[
//           FilteringTextInputFormatter.digitsOnly
//         ],
//         controller: controllerDialog,
//       ),
//       actions: [
//         TextButton(
//           onPressed: submit,
//           child: const Text('Submit'),
//         ),
//       ],
//     ));
//
// void submit() {
//   Navigator.of(context).pop(controllerDialog.text);
//   controllerDialog.clear();
// }
//
// @override
// Widget build(BuildContext context) {
//   double baseWidth = 375;
//   double fem = MediaQuery.of(context).size.width / baseWidth;
//   double ffem = fem * 0.97;
//
//   final controllerScanner = Get.put(DataScannerController());
//
//   return FutureBuilder(
//     future: controller.getLicensedCollectorAgentData(),
//     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//       if (snapshot.connectionState == ConnectionState.done) {
//         if (snapshot.hasData) {
//           LicensedCollectorModel licensedCollectorAgentData =
//           snapshot.data as LicensedCollectorModel;
//           splitName = licensedCollectorAgentData.username.split(" ");
//
//           //return Center(child: Text(licensedCollectorData.username));
//           return Scaffold(
//             backgroundColor: appWhite,
//             appBar: _toggleStatistics
//                 ? AppBar(
//               leading: widget.backNav
//                   ? null
//                   : Transform.scale(
//                 scale: 0.6,
//                 child: Image.asset(
//                   home_icon,
//                 ),
//               ),
//
//               title: Container(
//                 // welcomejonecau (4:3410)
//                 margin: EdgeInsets.fromLTRB(
//                     0 * fem, 0 * fem, 0 * fem, 0 * fem),
//                 child: RichText(
//                   text: TextSpan(
//                     style: SafeGoogleFont(
//                       'Inria Sans',
//                       fontSize: 16 * ffem,
//                       fontWeight: FontWeight.w700,
//                       height: 1.5 * ffem / fem,
//                       letterSpacing: 0.16 * fem,
//                       color: const Color(0xff1c162e),
//                     ),
//                     children: [
//                       TextSpan(
//                         text: 'Profile Overview',
//                         style: SafeGoogleFont(
//                           'Inria Sans',
//                           fontSize: 16 * ffem,
//                           fontWeight: FontWeight.w400,
//                           height: 1.5 * ffem / fem,
//                           letterSpacing: 0.16 * fem,
//                           color: const Color(0xff1c162e),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               //centerTitle: true,
//               elevation: 0,
//               backgroundColor: appWhite,
//               foregroundColor: appDark,
//               centerTitle: widget.backNav ? true : false,
//               //backgroundColor: const Color(0xfffdfdfe),
//               actions: [
//                 Container(
//                   margin: const EdgeInsets.only(right: 10, top: 7),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Wrap(spacing: -8, children: [
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         widget.backNav
//                             ? null
//                             : Icons.notifications_none,
//                         color: Colors.black,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: widget.backNav
//                           ? null
//                           : () {
//                         AuthenticationRepository.instance
//                             .logout();
//                       },
//                       icon: Icon(
//                         widget.backNav
//                             ? Icons.notifications_none
//                             : Icons.logout_outlined,
//                         color: widget.backNav ? appDark : appGold,
//                       ),
//                     ),
//                   ]),
//                 ),
//               ],
//             )
//                 : AppBar(
//               leading: _toggleQR
//                   ? Transform.scale(
//                 scale: 1,
//                 child: IconButton(
//                   onPressed: () => {
//                     _runFilter(currentDate),
//                     option = "Today's"
//                   },
//                   icon: Icon(
//                     Icons.refresh,
//                     color: appDark,
//                   ),
//                 ),
//               )
//                   : null,
//               title: Container(
//                 // welcomejonecau (4:3410)
//                 margin: EdgeInsets.fromLTRB(
//                     0 * fem, 0 * fem, 0 * fem, 0 * fem),
//                 child: RichText(
//                   text: TextSpan(
//                     style: SafeGoogleFont(
//                       'Inria Sans',
//                       fontSize: 16 * ffem,
//                       fontWeight: FontWeight.w700,
//                       height: 1.5 * ffem / fem,
//                       letterSpacing: 0.16 * fem,
//                       color: const Color(0xff1c162e),
//                     ),
//                     children: [
//                       _toggleQR
//                           ? TextSpan(
//                         text: 'Generate QR Code',
//                         style: SafeGoogleFont(
//                           'Inria Sans',
//                           fontSize: 16 * ffem,
//                           fontWeight: FontWeight.w400,
//                           height: 1.5 * ffem / fem,
//                           letterSpacing: 0.16 * fem,
//                           color: const Color(0xff1c162e),
//                         ),
//                       )
//                           : _toggleQR_Scanner
//                           ? TextSpan(
//                         text: 'Scan QR Code',
//                         style: SafeGoogleFont(
//                           'Inria Sans',
//                           fontSize: 16 * ffem,
//                           fontWeight: FontWeight.w400,
//                           height: 1.5 * ffem / fem,
//                           letterSpacing: 0.16 * fem,
//                           color: const Color(0xff1c162e),
//                         ),
//                       )
//                           : TextSpan(
//                         text: '',
//                         style: SafeGoogleFont(
//                           'Inria Sans',
//                           fontSize: 16 * ffem,
//                           fontWeight: FontWeight.w400,
//                           height: 1.5 * ffem / fem,
//                           letterSpacing: 0.16 * fem,
//                           color: const Color(0xff1c162e),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               //centerTitle: true,
//               elevation: 0,
//               backgroundColor: appWhite,
//               centerTitle: _toggleQR
//                   ? widget.backNav
//                   ? false
//                   : true
//                   : false,
//               //backgroundColor: const Color(0xfffdfdfe),
//               actions: [
//                 _toggleQR
//                     ? Container(
//                   margin:
//                   const EdgeInsets.only(right: 10, top: 7),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: IconButton(
//                     onPressed: () {
//                       _restorableDatePickerRouteFuture.present();
//                     },
//                     icon: const Icon(
//                       Icons.edit_calendar,
//                       color: Colors.black,
//                     ),
//                   ),
//                 )
//                     : Container(
//                   margin:
//                   const EdgeInsets.only(right: 10, top: 7),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Tooltip(
//                     message: 'Press to scan',
//                     child: IconButton(
//                       onPressed: _toggle,
//                       icon: const Icon(
//                         Icons.qr_code_scanner_rounded,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             TOPNavigationBar: Container(
//               // autogroupjqkfBnq (CGi6PsZNmTyRLzhGMKjqKF)
//               color: appWhite,
//               width: double.infinity,
//               height: 150 * fem,
//               //color: appGreen,
//               child: Stack(
//                 children: [
//                   Positioned(
//                     // lineL9w (I4:1812;143:612)
//                     left: 120 * fem,
//                     top: 171 * fem,
//                     child: Align(
//                       child: SizedBox(
//                         width: 135 * fem,
//                         height: 5 * fem,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100 * fem),
//                             color: Color(0xffffffff),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     // rectangle695TEZ (4:1813)
//                     left: 0 * fem,
//                     top: 0 * fem,
//                     child: Align(
//                       child: SizedBox(
//                         width: 375 * fem,
//                         height: 184 * fem,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Color(0xff1c162e),
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(30 * fem),
//                               topRight: Radius.circular(30 * fem),
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Color(0x4c000000),
//                                 offset: Offset(0 * fem, 0 * fem),
//                                 blurRadius: 10 * fem,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     // component8K1s (4:1814)
//                     left: 20 * fem,
//                     top: 20 * fem,
//                     child: GestureDetector(
//                       onTap: () {
//                         //Get.to(() => const DailyCollectionData());
//                         setState(
//                               () {
//                             _toggleStatistics = true;
//                             _toggleQR_Scanner = false;
//                             _toggleQR = false;
//                           },
//                         );
//                         //print('object');
//                       },
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 500),
//                         curve: Curves.fastOutSlowIn,
//                         padding: EdgeInsets.fromLTRB(
//                             33 * fem, 29 * fem, 33 * fem, 25.5 * fem),
//                         width: 96 * fem,
//                         height: 116 * fem,
//                         decoration: BoxDecoration(
//                           color: _toggleStatistics ? appGold : appDark,
//                           borderRadius: BorderRadius.circular(12 * fem),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               // component7iconszipsPXX (I4:1814;10071:8638)
//                               margin: EdgeInsets.fromLTRB(
//                                   0 * fem, 0 * fem, 0 * fem, 14.5 * fem),
//                               width: 30 * fem,
//                               height: 30 * fem,
//                               child: Image.asset(
//                                 statistic_white,
//                                 width: 30 * fem,
//                                 height: 30 * fem,
//                               ),
//                             ),
//                             Center(
//                               // billhHK (I4:1814;10071:8637)
//                               child: Container(
//                                 margin: EdgeInsets.fromLTRB(
//                                     1 * fem, 0 * fem, 0 * fem, 0 * fem),
//                                 child: Text(
//                                   'Stat',
//                                   textAlign: TextAlign.center,
//                                   style: SafeGoogleFont(
//                                     'Inria Sans',
//                                     fontSize: 14 * ffem,
//                                     fontWeight: FontWeight.w700,
//                                     height: 1.1975 * ffem / fem,
//                                     color: Color(0xffffffff),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     // component8QxR (4:1815)
//                     left: 140 * fem,
//                     top: 20 * fem,
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(
//                               () {
//                             _toggleStatistics = false;
//                             _toggleQR_Scanner = false;
//                             _toggleQR = true;
//                           },
//                         );
//                         //print('object');
//                       },
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 500),
//                         curve: Curves.fastOutSlowIn,
//                         padding: EdgeInsets.fromLTRB(
//                             22.5 * fem, 30.67 * fem, 21.5 * fem, 25.5 * fem),
//                         width: 96 * fem,
//                         height: 116 * fem,
//                         decoration: BoxDecoration(
//                           color: _toggleQR ? appGold : appDark,
//                           borderRadius: BorderRadius.circular(12 * fem),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               // component7iconspaymentbillGjj (I4:1815;10071:8638)
//                               margin: EdgeInsets.fromLTRB(
//                                   0 * fem, 0 * fem, 1 * fem, 16.17 * fem),
//                               width: 26.67 * fem,
//                               height: 26.67 * fem,
//                               child: Image.asset(
//                                 gen_qr_code,
//                                 width: 26.67 * fem,
//                                 height: 26.67 * fem,
//                               ),
//                             ),
//                             Center(
//                               // billAKK (I4:1815;10071:8637)
//                               child: Text(
//                                 'Gen_QR',
//                                 textAlign: TextAlign.center,
//                                 style: SafeGoogleFont(
//                                   'Inria Sans',
//                                   fontSize: 14 * ffem,
//                                   fontWeight: FontWeight.w700,
//                                   height: 1.1975 * ffem / fem,
//                                   color: Color(0xffffffff),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     // component8Huj (4:1816)
//                     left: 259 * fem,
//                     top: 20 * fem,
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(
//                               () {
//                             _toggleStatistics = false;
//                             _toggleQR_Scanner = true;
//                             _toggleQR = false;
//                           },
//                         );
//                         //print('object');
//                       },
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 500),
//                         curve: Curves.fastOutSlowIn,
//                         padding: EdgeInsets.fromLTRB(
//                             34.67 * fem, 33.33 * fem, 34.67 * fem, 24 * fem),
//                         width: 96 * fem,
//                         height: 116 * fem,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12 * fem),
//                           color: _toggleQR_Scanner ? appGold : appDark,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               // component7iconsscanqrcodejWq (I4:1816;10071:8638)
//                               margin: EdgeInsets.fromLTRB(
//                                   0 * fem, 0 * fem, 0 * fem, 17.33 * fem),
//                               width: 26.67 * fem,
//                               height: 21.33 * fem,
//                               child: Image.asset(
//                                 qr_scanner,
//                                 width: 26.67 * fem,
//                                 height: 21.33 * fem,
//                               ),
//                             ),
//                             Center(
//                               // billpHP (I4:1816;10071:8637)
//                               child: Container(
//                                 margin: EdgeInsets.fromLTRB(
//                                     1 * fem, 0 * fem, 0 * fem, 0 * fem),
//                                 child: Text(
//                                   'QR',
//                                   textAlign: TextAlign.center,
//                                   style: SafeGoogleFont(
//                                     'Inria Sans',
//                                     fontSize: 14 * ffem,
//                                     fontWeight: FontWeight.w700,
//                                     height: 1.4285714286 * ffem / fem,
//                                     color: Color(0xffffffff),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             body: SingleChildScrollView(
//               child: Container(
//                 margin:
//                 EdgeInsets.fromLTRB(0 * fem, 20 * fem, 0 * fem, 0 * fem),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.max,
//                   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     //Your elements here
//                     // Visibility(
//                     //   visible: _toggleStatistics,
//                     //   maintainAnimation: true,
//                     //   maintainState: true,
//                     //   child: AnimatedOpacity(
//                     //     duration: const Duration(milliseconds: 500),
//                     //     curve: Curves.fastOutSlowIn,
//                     //     opacity: _toggleStatistics ? 1 : 0,
//                     //     child: SizedBox(
//                     //       width: double.infinity,
//                     //       child: Container(
//                     //         // overviewRhb (4:3102)
//                     //
//                     //         padding: EdgeInsets.fromLTRB(
//                     //             0 * fem, 0 * fem, 0 * fem, 0 * fem),
//                     //         width: double.infinity,
//                     //         decoration: BoxDecoration(
//                     //           color: appWhite,
//                     //           //color: appGreen,
//                     //         ),
//                     //         child: Column(
//                     //           crossAxisAlignment: CrossAxisAlignment.start,
//                     //           children: [
//                     //             Container(
//                     //               // hijonexQ1 (4:3105)
//                     //               margin: EdgeInsets.fromLTRB(
//                     //                   20 * fem, 0 * fem, 0 * fem, 6 * fem),
//                     //               child: Text(
//                     //                 'Hi, ${splitName[0]}!',
//                     //                 style: SafeGoogleFont(
//                     //                   'Inria Sans',
//                     //                   fontSize: 26 * ffem,
//                     //                   fontWeight: FontWeight.w700,
//                     //                   height: 1.8461538462 * ffem / fem,
//                     //                   letterSpacing: 0.26 * fem,
//                     //                   color: Color(0xff1c162e),
//                     //                 ),
//                     //               ),
//                     //             ),
//                     //             Container(
//                     //               // whatwillyoudotoday3gM (4:3107)
//                     //               margin: EdgeInsets.fromLTRB(
//                     //                   20 * fem, 0 * fem, 0 * fem, 0 * fem),
//                     //               child: Text(
//                     //                 'Collection records and updates',
//                     //                 style: SafeGoogleFont(
//                     //                   'Inria Sans',
//                     //                   fontSize: 15 * ffem,
//                     //                   fontWeight: FontWeight.w400,
//                     //                   height: 1.1975 * ffem / fem,
//                     //                   letterSpacing: 0.15 * fem,
//                     //                   color: Color(0xffc6c4ca),
//                     //                 ),
//                     //               ),
//                     //             ),
//                     //             SizedBox(
//                     //               height: 20 * fem,
//                     //             ),
//                     //             Container(
//                     //               //color: appGold,
//                     //               // autogroup2zxf9UV (CGiGta58ayzBN6oaui2ZXF)
//                     //               padding: EdgeInsets.fromLTRB(
//                     //                   20 * fem, 40 * fem, 20 * fem, 65 * fem),
//                     //               width: double.infinity,
//                     //               //height: MediaQuery.of(context).size.height,
//                     //               child: Column(
//                     //                 crossAxisAlignment: CrossAxisAlignment.center,
//                     //                 children: [
//                     //                   Container(
//                     //                     // autogroupccz5oxM (CGiECUtYo34uURMAt3Ccz5)
//                     //                     margin: EdgeInsets.fromLTRB(
//                     //                         0 * fem, 0 * fem, 0 * fem, 25 * fem),
//                     //                     width: double.infinity,
//                     //                     height: 158 * fem,
//                     //                     child: Row(
//                     //                       crossAxisAlignment:
//                     //                           CrossAxisAlignment.center,
//                     //                       children: [
//                     //                         Container(
//                     //                           // cardtokenbonus7y3 (4:3109)
//                     //                           margin: EdgeInsets.fromLTRB(0 * fem,
//                     //                               0 * fem, 25 * fem, 0 * fem),
//                     //                           padding: EdgeInsets.fromLTRB(13 * fem,
//                     //                               15 * fem, 14 * fem, 20 * fem),
//                     //                           width: 155 * fem,
//                     //                           height: double.infinity,
//                     //                           decoration: BoxDecoration(
//                     //                             color: Color(0xff1c162e),
//                     //                             borderRadius:
//                     //                                 BorderRadius.circular(12 * fem),
//                     //                             boxShadow: [
//                     //                               BoxShadow(
//                     //                                 color: Color(0x7f7d64ff),
//                     //                                 offset: Offset(0 * fem, 8 * fem),
//                     //                                 blurRadius: 10 * fem,
//                     //                               ),
//                     //                             ],
//                     //                           ),
//                     //                           child: Column(
//                     //                             crossAxisAlignment:
//                     //                                 CrossAxisAlignment.center,
//                     //                             children: [
//                     //                               Container(
//                     //                                 // autogroupktjooay (CGiETUTZsdonGjVu3ykTjo)
//                     //                                 margin: EdgeInsets.fromLTRB(
//                     //                                     3 * fem,
//                     //                                     0 * fem,
//                     //                                     0.95 * fem,
//                     //                                     18 * fem),
//                     //                                 width: double.infinity,
//                     //                                 child: Row(
//                     //                                   crossAxisAlignment:
//                     //                                       CrossAxisAlignment.center,
//                     //                                   mainAxisAlignment:
//                     //                                       MainAxisAlignment
//                     //                                           .spaceBetween,
//                     //                                   children: [
//                     //                                     Container(
//                     //                                       // dashboardixq (4:3110)
//                     //                                       margin: EdgeInsets.fromLTRB(
//                     //                                           0 * fem,
//                     //                                           0 * fem,
//                     //                                           0 * fem,
//                     //                                           //45.05 * fem,
//                     //                                           0 * fem),
//                     //                                       child: Text(
//                     //                                         'Collections',
//                     //                                         style: SafeGoogleFont(
//                     //                                           'Inria Sans',
//                     //                                           fontSize: 14 * ffem,
//                     //                                           fontWeight:
//                     //                                               FontWeight.w700,
//                     //                                           height:
//                     //                                               1.1975 * ffem / fem,
//                     //                                           color:
//                     //                                               Color(0xffffffff),
//                     //                                         ),
//                     //                                       ),
//                     //                                     ),
//                     //                                     Container(
//                     //                                       // arrowdown338S89 (4:3111)
//                     //                                       margin: EdgeInsets.fromLTRB(
//                     //                                           0 * fem,
//                     //                                           3 * fem,
//                     //                                           0 * fem,
//                     //                                           0 * fem),
//                     //                                       width: 12 * fem,
//                     //                                       height: 6.6 * fem,
//                     //                                       child: Image.asset(
//                     //                                         down_arrow,
//                     //                                         width: 12 * fem,
//                     //                                         height: 6.6 * fem,
//                     //                                       ),
//                     //                                     ),
//                     //                                   ],
//                     //                                 ),
//                     //                               ),
//                     //                               Container(
//                     //                                 // autogroupznn5kuX (CGiEaDmKroe5LB4pq3znn5)
//                     //                                 margin: EdgeInsets.fromLTRB(
//                     //                                     6 * fem,
//                     //                                     0 * fem,
//                     //                                     5 * fem,
//                     //                                     7 * fem),
//                     //                                 width: double.infinity,
//                     //                                 height: 67 * fem,
//                     //                                 child: Row(
//                     //                                   crossAxisAlignment:
//                     //                                       CrossAxisAlignment.end,
//                     //                                   children: [
//                     //                                     Container(
//                     //                                       // autogroupzvrbVcD (CGiEjYq7eCYXnQwNDzZVRb)
//                     //                                       padding:
//                     //                                           EdgeInsets.fromLTRB(
//                     //                                               0 * fem,
//                     //                                               22 * fem,
//                     //                                               23 * fem,
//                     //                                               0 * fem),
//                     //                                       height: double.infinity,
//                     //                                       child: Row(
//                     //                                         crossAxisAlignment:
//                     //                                             CrossAxisAlignment
//                     //                                                 .end,
//                     //                                         children: [
//                     //                                           Container(
//                     //                                             // rectangle477nrD (4:3117)
//                     //                                             width: 5 * fem,
//                     //                                             height: 22 * fem,
//                     //                                             decoration:
//                     //                                                 BoxDecoration(
//                     //                                               borderRadius:
//                     //                                                   BorderRadius
//                     //                                                       .circular(
//                     //                                                           8 * fem),
//                     //                                               color: const Color(
//                     //                                                   0xffffd035),
//                     //                                             ),
//                     //                                           ),
//                     //                                           SizedBox(
//                     //                                             width: 23 * fem,
//                     //                                           ),
//                     //                                           Container(
//                     //                                             // rectangle479J3s (4:3118)
//                     //                                             width: 5 * fem,
//                     //                                             height: 36 * fem,
//                     //                                             decoration:
//                     //                                                 BoxDecoration(
//                     //                                               borderRadius:
//                     //                                                   BorderRadius
//                     //                                                       .circular(
//                     //                                                           8 * fem),
//                     //                                               color: const Color(
//                     //                                                   0xffffd035),
//                     //                                             ),
//                     //                                           ),
//                     //                                           SizedBox(
//                     //                                             width: 23 * fem,
//                     //                                           ),
//                     //                                           Container(
//                     //                                             // rectangle481SA5 (4:3119)
//                     //                                             width: 5 * fem,
//                     //                                             height: 45 * fem,
//                     //                                             decoration:
//                     //                                                 BoxDecoration(
//                     //                                               borderRadius:
//                     //                                                   BorderRadius
//                     //                                                       .circular(
//                     //                                                           8 * fem),
//                     //                                               color: const Color(
//                     //                                                   0xffffd035),
//                     //                                             ),
//                     //                                           ),
//                     //                                         ],
//                     //                                       ),
//                     //                                     ),
//                     //                                     Container(
//                     //                                       // rectangle4836VX (4:3120)
//                     //                                       margin: EdgeInsets.fromLTRB(
//                     //                                           0 * fem,
//                     //                                           0 * fem,
//                     //                                           23 * fem,
//                     //                                           0 * fem),
//                     //                                       width: 5 * fem,
//                     //                                       height: 67 * fem,
//                     //                                       decoration: BoxDecoration(
//                     //                                         borderRadius:
//                     //                                             BorderRadius.circular(
//                     //                                                 8 * fem),
//                     //                                         color: const Color(
//                     //                                             0xffffd035),
//                     //                                       ),
//                     //                                     ),
//                     //                                     Container(
//                     //                                       // rectangle4852PB (4:3121)
//                     //                                       width: 5 * fem,
//                     //                                       height: 51 * fem,
//                     //                                       decoration: BoxDecoration(
//                     //                                         borderRadius:
//                     //                                             BorderRadius.circular(
//                     //                                                 8 * fem),
//                     //                                         color: const Color(
//                     //                                             0xffffd035),
//                     //                                       ),
//                     //                                     ),
//                     //                                   ],
//                     //                                 ),
//                     //                               ),
//                     //                               Container(
//                     //                                 // autogroupmnfbmrZ (CGiEuDDgZRuicJbDK7Mnfb)
//                     //                                 width: double.infinity,
//                     //                                 child: Row(
//                     //                                   crossAxisAlignment:
//                     //                                       CrossAxisAlignment.center,
//                     //                                   mainAxisAlignment:
//                     //                                       MainAxisAlignment
//                     //                                           .spaceBetween,
//                     //                                   children: [
//                     //                                     Container(
//                     //                                       // margTj (4:3112)
//                     //                                       // margin: EdgeInsets.fromLTRB(
//                     //                                       //     0 * fem,
//                     //                                       //     0 * fem,
//                     //                                       //     12 * fem,
//                     //                                       //     0 * fem),
//                     //                                       child: Text(
//                     //                                         'Mar',
//                     //                                         style: SafeGoogleFont(
//                     //                                           'Dosis',
//                     //                                           fontSize: 11 * ffem,
//                     //                                           fontWeight:
//                     //                                               FontWeight.w500,
//                     //                                           height:
//                     //                                               1.265 * ffem / fem,
//                     //                                           letterSpacing:
//                     //                                               0.11 * fem,
//                     //                                           color: const Color(
//                     //                                               0xffffffff),
//                     //                                         ),
//                     //                                       ),
//                     //                                     ),
//                     //                                     Container(
//                     //                                       // aprb4u (4:3113)
//                     //                                       // margin: EdgeInsets.fromLTRB(
//                     //                                       //     0 * fem,
//                     //                                       //     0 * fem,
//                     //                                       //     11 * fem,
//                     //                                       //     0 * fem),
//                     //                                       child: Text(
//                     //                                         'Apr',
//                     //                                         style: SafeGoogleFont(
//                     //                                           'Dosis',
//                     //                                           fontSize: 11 * ffem,
//                     //                                           fontWeight:
//                     //                                               FontWeight.w500,
//                     //                                           height:
//                     //                                               1.265 * ffem / fem,
//                     //                                           letterSpacing:
//                     //                                               0.11 * fem,
//                     //                                           color: const Color(
//                     //                                               0xffffffff),
//                     //                                         ),
//                     //                                       ),
//                     //                                     ),
//                     //                                     Container(
//                     //                                       // mayi9X (4:3114)
//                     //                                       // margin: EdgeInsets.fromLTRB(
//                     //                                       //     0 * fem,
//                     //                                       //     0 * fem,
//                     //                                       //     10 * fem,
//                     //                                       //     0 * fem),
//                     //                                       child: Text(
//                     //                                         'May',
//                     //                                         style: SafeGoogleFont(
//                     //                                           'Dosis',
//                     //                                           fontSize: 11 * ffem,
//                     //                                           fontWeight:
//                     //                                               FontWeight.w500,
//                     //                                           height:
//                     //                                               1.265 * ffem / fem,
//                     //                                           letterSpacing:
//                     //                                               0.11 * fem,
//                     //                                           color:
//                     //                                               Color(0xffffffff),
//                     //                                         ),
//                     //                                       ),
//                     //                                     ),
//                     //                                     Container(
//                     //                                       // junqjw (4:3115)
//                     //                                       // margin: EdgeInsets.fromLTRB(
//                     //                                       //     0 * fem,
//                     //                                       //     0 * fem,
//                     //                                       //     12 * fem,
//                     //                                       //     0 * fem),
//                     //                                       child: Text(
//                     //                                         'Jun',
//                     //                                         style: SafeGoogleFont(
//                     //                                           'Dosis',
//                     //                                           fontSize: 11 * ffem,
//                     //                                           fontWeight:
//                     //                                               FontWeight.w500,
//                     //                                           height:
//                     //                                               1.265 * ffem / fem,
//                     //                                           letterSpacing:
//                     //                                               0.11 * fem,
//                     //                                           color: const Color(
//                     //                                               0xffffffff),
//                     //                                         ),
//                     //                                       ),
//                     //                                     ),
//                     //                                     Text(
//                     //                                       // julyLM (4:3116)
//                     //                                       'Jul',
//                     //                                       style: SafeGoogleFont(
//                     //                                         'Dosis',
//                     //                                         fontSize: 11 * ffem,
//                     //                                         fontWeight:
//                     //                                             FontWeight.w500,
//                     //                                         height:
//                     //                                             1.265 * ffem / fem,
//                     //                                         letterSpacing: 0.11 * fem,
//                     //                                         color: Color(0xffffffff),
//                     //                                       ),
//                     //                                     ),
//                     //                                   ],
//                     //                                 ),
//                     //                               ),
//                     //                               //   ),
//                     //                               // ),
//                     //                             ],
//                     //                           ),
//                     //                         ),
//                     //                         Container(
//                     //                           // cardtokenbonus5eH (4:3131)
//                     //                           padding: EdgeInsets.fromLTRB(16 * fem,
//                     //                               15 * fem, 15.34 * fem, 18 * fem),
//                     //                           width: 155 * fem,
//                     //                           height: double.infinity,
//                     //                           decoration: BoxDecoration(
//                     //                             color: const Color(0xffffffff),
//                     //                             borderRadius:
//                     //                                 BorderRadius.circular(12 * fem),
//                     //                             boxShadow: [
//                     //                               BoxShadow(
//                     //                                 color: const Color(0x14404040),
//                     //                                 offset: Offset(0 * fem, 8 * fem),
//                     //                                 blurRadius: 10 * fem,
//                     //                               ),
//                     //                             ],
//                     //                           ),
//                     //                           child: Column(
//                     //                             crossAxisAlignment:
//                     //                                 CrossAxisAlignment.start,
//                     //                             children: [
//                     //                               Container(
//                     //                                 // autogroupsudjRLm (CGiFMXoAESKS6mJK33sudj)
//                     //                                 margin: EdgeInsets.fromLTRB(
//                     //                                     0 * fem,
//                     //                                     0 * fem,
//                     //                                     0 * fem,
//                     //                                     41 * fem),
//                     //                                 width: double.infinity,
//                     //                                 child: Row(
//                     //                                   crossAxisAlignment:
//                     //                                       CrossAxisAlignment.center,
//                     //                                   children: [
//                     //                                     Container(
//                     //                                       // invoicektq (4:3132)
//                     //                                       margin: EdgeInsets.fromLTRB(
//                     //                                           0 * fem,
//                     //                                           0 * fem,
//                     //                                           0 * fem,
//                     //                                           //66.97 * fem,
//                     //                                           0 * fem),
//                     //                                       child: Text(
//                     //                                         'Houses',
//                     //                                         style: SafeGoogleFont(
//                     //                                           'Inria Sans',
//                     //                                           fontSize: 14 * ffem,
//                     //                                           fontWeight:
//                     //                                               FontWeight.w700,
//                     //                                           height: 1.4285714286 *
//                     //                                               ffem /
//                     //                                               fem,
//                     //                                         ),
//                     //                                       ),
//                     //                                     ),
//                     //                                     Container(
//                     //                                       // arrowdown338U49 (4:3135)
//                     //                                       margin: EdgeInsets.fromLTRB(
//                     //                                           0 * fem,
//                     //                                           0 * fem,
//                     //                                           0 * fem,
//                     //                                           0 * fem),
//                     //                                       width: 11.68 * fem,
//                     //                                       height: 6.6 * fem,
//                     //                                       child: Image.asset(
//                     //                                         down_arrow,
//                     //                                         width: 11.68 * fem,
//                     //                                         height: 6.6 * fem,
//                     //                                       ),
//                     //                                     ),
//                     //                                   ],
//                     //                                 ),
//                     //                               ),
//                     //                               widget.backNav
//                     //                                   ? Text(
//                     //                                       // Bz9 (4:3134)
//                     //                                       '96',
//                     //                                       style: SafeGoogleFont(
//                     //                                         'Inria Sans',
//                     //                                         fontSize: 26 * ffem,
//                     //                                         fontWeight:
//                     //                                             FontWeight.w700,
//                     //                                         height: 1.8461538462 *
//                     //                                             ffem /
//                     //                                             fem,
//                     //                                         letterSpacing: 0.26 * fem,
//                     //                                         color: Color(0xff1c162e),
//                     //                                       ),
//                     //                                     )
//                     //                                   : Text(
//                     //                                       // Bz9 (4:3134)
//                     //                                       '16',
//                     //                                       style: SafeGoogleFont(
//                     //                                         'Inria Sans',
//                     //                                         fontSize: 26 * ffem,
//                     //                                         fontWeight:
//                     //                                             FontWeight.w700,
//                     //                                         height: 1.8461538462 *
//                     //                                             ffem /
//                     //                                             fem,
//                     //                                         letterSpacing: 0.26 * fem,
//                     //                                         color: Color(0xff1c162e),
//                     //                                       ),
//                     //                                     ),
//                     //                               Text(
//                     //                                 // projectandinvoice8uP (4:3133)
//                     //                                 'Total houses visited',
//                     //                                 style: SafeGoogleFont(
//                     //                                   'Inria Sans',
//                     //                                   fontSize: 12 * ffem,
//                     //                                   fontWeight: FontWeight.w400,
//                     //                                   height:
//                     //                                       1.3333333333 * ffem / fem,
//                     //                                   letterSpacing: 0.12 * fem,
//                     //                                   color: Color(0xff1c162e),
//                     //                                 ),
//                     //                               ),
//                     //                             ],
//                     //                           ),
//                     //                         ),
//                     //                       ],
//                     //                     ),
//                     //                   ),
//                     //                   Container(
//                     //                     // autogroupbrrygAD (CGiFUwkUVH5BuWRrCUbRry)
//                     //                     width: double.infinity,
//                     //                     height: 158 * fem,
//                     //                     child: Row(
//                     //                       crossAxisAlignment:
//                     //                           CrossAxisAlignment.center,
//                     //                       children: [
//                     //                         Container(
//                     //                           // cardtokenbonusdbF (4:3122)
//                     //                           margin: EdgeInsets.fromLTRB(0 * fem,
//                     //                               0 * fem, 25 * fem, 0 * fem),
//                     //                           padding: EdgeInsets.fromLTRB(16 * fem,
//                     //                               16 * fem, 14.95 * fem, 16 * fem),
//                     //                           width: 155 * fem,
//                     //                           height: double.infinity,
//                     //                           decoration: BoxDecoration(
//                     //                             color: const Color(0xffffffff),
//                     //                             borderRadius:
//                     //                                 BorderRadius.circular(12 * fem),
//                     //                             boxShadow: [
//                     //                               BoxShadow(
//                     //                                 color: const Color(0x14404040),
//                     //                                 offset: Offset(0 * fem, 8 * fem),
//                     //                                 blurRadius: 10 * fem,
//                     //                               ),
//                     //                             ],
//                     //                           ),
//                     //                           child: Column(
//                     //                             crossAxisAlignment:
//                     //                                 CrossAxisAlignment.start,
//                     //                             children: [
//                     //                               Container(
//                     //                                 // autogroupsudjRLm (CGiFMXoAESKS6mJK33sudj)
//                     //                                 margin: EdgeInsets.fromLTRB(
//                     //                                     0 * fem,
//                     //                                     0 * fem,
//                     //                                     0 * fem,
//                     //                                     41 * fem),
//                     //                                 width: double.infinity,
//                     //                                 child: Row(
//                     //                                   crossAxisAlignment:
//                     //                                       CrossAxisAlignment.center,
//                     //                                   children: [
//                     //                                     Container(
//                     //                                       // invoicektq (4:3132)
//                     //                                       margin: EdgeInsets.fromLTRB(
//                     //                                           0 * fem,
//                     //                                           0 * fem,
//                     //                                           66.97 * fem,
//                     //                                           0 * fem),
//                     //                                       child: Text(
//                     //                                         'Wet',
//                     //                                         style: SafeGoogleFont(
//                     //                                           'Inria Sans',
//                     //                                           fontSize: 14 * ffem,
//                     //                                           fontWeight:
//                     //                                               FontWeight.w700,
//                     //                                           height: 1.4285714286 *
//                     //                                               ffem /
//                     //                                               fem,
//                     //                                         ),
//                     //                                       ),
//                     //                                     ),
//                     //                                     Container(
//                     //                                       // arrowdown338U49 (4:3135)
//                     //                                       margin: EdgeInsets.fromLTRB(
//                     //                                           0 * fem,
//                     //                                           0 * fem,
//                     //                                           0 * fem,
//                     //                                           0 * fem),
//                     //                                       width: 11.68 * fem,
//                     //                                       height: 6.6 * fem,
//                     //                                       child: Image.asset(
//                     //                                         down_arrow,
//                     //                                         width: 11.68 * fem,
//                     //                                         height: 6.6 * fem,
//                     //                                       ),
//                     //                                     ),
//                     //                                   ],
//                     //                                 ),
//                     //                               ),
//                     //                               widget.backNav
//                     //                                   ? Text(
//                     //                                       // Bz9 (4:3134)
//                     //                                       '657kgs',
//                     //                                       style: SafeGoogleFont(
//                     //                                         'Inria Sans',
//                     //                                         fontSize: 26 * ffem,
//                     //                                         fontWeight:
//                     //                                             FontWeight.w700,
//                     //                                         height: 1.8461538462 *
//                     //                                             ffem /
//                     //                                             fem,
//                     //                                         letterSpacing: 0.26 * fem,
//                     //                                         color: const Color(
//                     //                                             0xff1c162e),
//                     //                                       ),
//                     //                                     )
//                     //                                   : Text(
//                     //                                       // Bz9 (4:3134)
//                     //                                       '257kgs',
//                     //                                       style: SafeGoogleFont(
//                     //                                         'Inria Sans',
//                     //                                         fontSize: 26 * ffem,
//                     //                                         fontWeight:
//                     //                                             FontWeight.w700,
//                     //                                         height: 1.8461538462 *
//                     //                                             ffem /
//                     //                                             fem,
//                     //                                         letterSpacing: 0.26 * fem,
//                     //                                         color: const Color(
//                     //                                             0xff1c162e),
//                     //                                       ),
//                     //                                     ),
//                     //                               Text(
//                     //                                 // projectandinvoice8uP (4:3133)
//                     //                                 'Total Wet Weight',
//                     //                                 style: SafeGoogleFont(
//                     //                                   'Inria Sans',
//                     //                                   fontSize: 12 * ffem,
//                     //                                   fontWeight: FontWeight.w400,
//                     //                                   height:
//                     //                                       1.3333333333 * ffem / fem,
//                     //                                   letterSpacing: 0.12 * fem,
//                     //                                   color: const Color(0xff1c162e),
//                     //                                 ),
//                     //                               ),
//                     //                             ],
//                     //                           ),
//                     //                         ),
//                     //                         Container(
//                     //                           // cardtokenbonus5eH (4:3131)
//                     //                           padding: EdgeInsets.fromLTRB(16 * fem,
//                     //                               15 * fem, 15.34 * fem, 18 * fem),
//                     //                           width: 155 * fem,
//                     //                           height: double.infinity,
//                     //                           decoration: BoxDecoration(
//                     //                             color: const Color(0xffffffff),
//                     //                             borderRadius:
//                     //                                 BorderRadius.circular(12 * fem),
//                     //                             boxShadow: [
//                     //                               BoxShadow(
//                     //                                 color: const Color(0x14404040),
//                     //                                 offset: Offset(0 * fem, 8 * fem),
//                     //                                 blurRadius: 10 * fem,
//                     //                               ),
//                     //                             ],
//                     //                           ),
//                     //                           child: Column(
//                     //                             crossAxisAlignment:
//                     //                                 CrossAxisAlignment.start,
//                     //                             children: [
//                     //                               Container(
//                     //                                 // autogroupsudjRLm (CGiFMXoAESKS6mJK33sudj)
//                     //                                 margin: EdgeInsets.fromLTRB(
//                     //                                     0 * fem,
//                     //                                     0 * fem,
//                     //                                     0 * fem,
//                     //                                     41 * fem),
//                     //                                 width: double.infinity,
//                     //                                 child: Row(
//                     //                                   crossAxisAlignment:
//                     //                                       CrossAxisAlignment.center,
//                     //                                   children: [
//                     //                                     Container(
//                     //                                       // invoicektq (4:3132)
//                     //                                       margin: EdgeInsets.fromLTRB(
//                     //                                           0 * fem,
//                     //                                           0 * fem,
//                     //                                           66.97 * fem,
//                     //                                           0 * fem),
//                     //                                       child: Text(
//                     //                                         'Dry',
//                     //                                         style: SafeGoogleFont(
//                     //                                           'Inria Sans',
//                     //                                           fontSize: 14 * ffem,
//                     //                                           fontWeight:
//                     //                                               FontWeight.w700,
//                     //                                           height: 1.4285714286 *
//                     //                                               ffem /
//                     //                                               fem,
//                     //                                         ),
//                     //                                       ),
//                     //                                     ),
//                     //                                     Container(
//                     //                                       // arrowdown338U49 (4:3135)
//                     //                                       margin: EdgeInsets.fromLTRB(
//                     //                                           0 * fem,
//                     //                                           0 * fem,
//                     //                                           0 * fem,
//                     //                                           0 * fem),
//                     //                                       width: 11.68 * fem,
//                     //                                       height: 6.6 * fem,
//                     //                                       child: Image.asset(
//                     //                                         down_arrow,
//                     //                                         width: 11.68 * fem,
//                     //                                         height: 6.6 * fem,
//                     //                                       ),
//                     //                                     ),
//                     //                                   ],
//                     //                                 ),
//                     //                               ),
//                     //                               widget.backNav
//                     //                                   ? Text(
//                     //                                       // Bz9 (4:3134)
//                     //                                       '720kgs',
//                     //                                       style: SafeGoogleFont(
//                     //                                         'Inria Sans',
//                     //                                         fontSize: 26 * ffem,
//                     //                                         fontWeight:
//                     //                                             FontWeight.w700,
//                     //                                         height: 1.8461538462 *
//                     //                                             ffem /
//                     //                                             fem,
//                     //                                         letterSpacing: 0.26 * fem,
//                     //                                         color: Color(0xff1c162e),
//                     //                                       ),
//                     //                                     )
//                     //                                   : Text(
//                     //                                       // Bz9 (4:3134)
//                     //                                       '320kgs',
//                     //                                       style: SafeGoogleFont(
//                     //                                         'Inria Sans',
//                     //                                         fontSize: 26 * ffem,
//                     //                                         fontWeight:
//                     //                                             FontWeight.w700,
//                     //                                         height: 1.8461538462 *
//                     //                                             ffem /
//                     //                                             fem,
//                     //                                         letterSpacing: 0.26 * fem,
//                     //                                         color: Color(0xff1c162e),
//                     //                                       ),
//                     //                                     ),
//                     //                               Text(
//                     //                                 // projectandinvoice8uP (4:3133)
//                     //                                 'Total Dry Weight',
//                     //                                 style: SafeGoogleFont(
//                     //                                   'Inria Sans',
//                     //                                   fontSize: 12 * ffem,
//                     //                                   fontWeight: FontWeight.w400,
//                     //                                   height:
//                     //                                       1.3333333333 * ffem / fem,
//                     //                                   letterSpacing: 0.12 * fem,
//                     //                                   color: Color(0xff1c162e),
//                     //                                 ),
//                     //                               ),
//                     //                             ],
//                     //                           ),
//                     //                         ),
//                     //                       ],
//                     //                     ),
//                     //                   ),
//                     //                 ],
//                     //               ),
//                     //             ),
//                     //           ],
//                     //         ),
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ),
//                     Visibility(
//                       visible: _toggleQR,
//                       maintainAnimation: true,
//                       maintainState: true,
//                       child: AnimatedOpacity(
//                         duration: const Duration(milliseconds: 500),
//                         curve: Curves.fastOutSlowIn,
//                         opacity: _toggleQR ? 1 : 0,
//                         child: SizedBox(
//                           width: double.infinity,
//                           child: Container(
//                             // overviewRhb (4:3102)
//
//                             padding: EdgeInsets.fromLTRB(
//                                 0 * fem, 0 * fem, 0 * fem, 0 * fem),
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: appWhite,
//                               //color: appGreen,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Visibility(
//                                   visible: widget.backNav,
//                                   child: SizedBox(
//                                     height: 50 * fem,
//                                   ),
//                                 ),
//                                 Visibility(
//                                   visible: widget.backNav,
//                                   child: QrImageView(
//                                     data:
//                                     'Name: ${widget.collectorName}, Wet: $wettotal, Dry: $drytotal, Date: $currentDate, QR@KMFRI',
//                                     version: QrVersions.auto,
//                                     size: 300 * fem,
//                                     backgroundColor: Colors.white,
//                                     //data: '$_toggleQR',
//                                   ),
//                                 ),
//                                 Visibility(
//                                   visible: widget.backNav,
//                                   child: SizedBox(
//                                     height: 20 * fem,
//                                     child: Text(
//                                       'Scan to transfer data.',
//                                       style: SafeGoogleFont(
//                                         'Inria Sans',
//                                         fontSize: 12 * ffem,
//                                         fontWeight: FontWeight.w400,
//                                         height: 1.3333333333 * ffem / fem,
//                                         letterSpacing: 0.12 * fem,
//                                         color: Color(0xff1c162e),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Visibility(
//                                   visible: widget.backNav,
//                                   child: SizedBox(
//                                     height: 20 * fem,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   //height: 40 * fem,
//                                   child: _visible
//                                       ? Text(
//                                     // projectandinvoice8uP (4:3133)
//                                     '$option Collection Data',
//                                     textAlign: TextAlign.center,
//                                     style: SafeGoogleFont(
//                                       'Inria Sans',
//                                       fontSize: 20 * ffem,
//                                       fontWeight: FontWeight.w400,
//                                       height: 1.3333333333 * ffem / fem,
//                                       letterSpacing: 0.12 * fem,
//                                       color: Color(0xff1c162e),
//                                     ),
//                                   )
//                                       : Text(
//                                     // projectandinvoice8uP (4:3133)
//                                     '$option\nNo Record Found ',
//                                     textAlign: TextAlign.center,
//                                     style: SafeGoogleFont(
//                                       'Inria Sans',
//                                       fontSize: 20 * ffem,
//                                       fontWeight: FontWeight.w400,
//                                       height: 1.3333333333 * ffem / fem,
//                                       letterSpacing: 0.12 * fem,
//                                       color: Color(0xff1c162e),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 20 * fem,
//                                 ),
//                                 Container(
//                                   color: appWhite,
//                                   constraints: const BoxConstraints(
//                                     minHeight: 100,
//                                     minWidth: double.infinity,
//                                   ),
//                                   child: ListView(
//                                     shrinkWrap: true,
//                                     padding:
//                                     const EdgeInsets.only(right: 10, left: 10),
//                                     children: <Widget>[
//                                       ...List.generate(
//                                         _foundUsers.length,
//                                         // Replace this with 1, 2 to see min height works.
//                                             (index) => ListTile(
//                                           leading: CircleAvatar(
//                                             radius: 30,
//                                             backgroundColor: appDark,
//                                             child: Text(
//                                               //listDailyCollections[index].house.substring(3),
//                                               _foundUsers[index]["house"]
//                                                   .substring(3),
//                                               style: const TextStyle(
//                                                   color: Colors.white,
//                                                   fontFamily: 'ProximaNova',
//                                                   fontWeight: FontWeight.bold,
//                                                   fontStyle: FontStyle.italic,
//                                                   fontSize: 20.0),
//                                             ),
//                                             //backgroundImage: AssetImage(listDailyCollections[index].pictures),
//                                           ),
//                                           title: Text(
//                                             _foundUsers[index]["house"],
//                                             style: TextStyle(color: appDark),
//                                           ),
//                                           //listDailyCollections[index].house),
//                                           trailing: Wrap(
//                                             spacing: -16,
//                                             children: [
//                                               IconButton(
//                                                 icon: Icon(Icons.edit_note,
//                                                     color: appGold),
//                                                 onPressed: () {
//                                                   var messageWet = '';
//                                                   var messageDry = '';
//                                                   CoolAlert.show(
//                                                     context: context,
//                                                     type: CoolAlertType.custom,
//                                                     barrierDismissible: true,
//                                                     confirmBtnText: 'Save',
//                                                     cancelBtnText: 'Cancel',
//                                                     widget: Column(
//                                                       children: [
//                                                         Text(
//                                                           //'House Number: ${listDailyCollections[index].house}',
//                                                           'House Number: ${_foundUsers[index]["house"]}',
//                                                           style: const TextStyle(
//                                                             //color: Colors.white,
//                                                               fontFamily:
//                                                               'ProximaNova',
//                                                               fontWeight:
//                                                               FontWeight.bold,
//                                                               //fontStyle: FontStyle.italic,
//                                                               fontSize: 20.0),
//                                                         ),
//                                                         const SizedBox(
//                                                           height: 20,
//                                                         ),
//                                                         TextFormField(
//                                                           decoration:
//                                                           const InputDecoration(
//                                                             hintText: 'Wet Weight',
//                                                             prefixIcon: Icon(
//                                                               Icons.water_drop,
//                                                             ),
//                                                           ),
//                                                           textInputAction:
//                                                           TextInputAction.next,
//                                                           keyboardType:
//                                                           TextInputType.number,
//                                                           onChanged: (value) =>
//                                                           messageWet = value,
//                                                         ),
//                                                         const SizedBox(
//                                                           height: 20,
//                                                         ),
//                                                         TextFormField(
//                                                           decoration:
//                                                           const InputDecoration(
//                                                             hintText: 'Dry Weight',
//                                                             prefixIcon: Icon(
//                                                               Icons.wb_sunny,
//                                                             ),
//                                                           ),
//                                                           textInputAction:
//                                                           TextInputAction.next,
//                                                           keyboardType:
//                                                           TextInputType.number,
//                                                           onChanged: (value) =>
//                                                           messageDry = value,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     closeOnConfirmBtnTap: false,
//                                                     onConfirmBtnTap: () async {
//                                                       if (messageWet == '') {
//                                                         await CoolAlert.show(
//                                                           context: context,
//                                                           type: CoolAlertType.error,
//                                                           text:
//                                                           'Wet weight can not be empty',
//                                                         );
//
//                                                         return;
//                                                       }
//                                                       if (messageDry == '') {
//                                                         await CoolAlert.show(
//                                                           context: context,
//                                                           type: CoolAlertType.error,
//                                                           text:
//                                                           'Dry weight can not be empty',
//                                                         );
//
//                                                         return;
//                                                       }
//                                                       Navigator.of(context).pop();
//                                                       await Future.delayed(
//                                                           const Duration(
//                                                               milliseconds: 500),
//                                                               () async {
//                                                             await CoolAlert.show(
//                                                               context: context,
//                                                               type: CoolAlertType.success,
//                                                               text:
//                                                               "Wet weight: $messageWet Kgs, Dry weight: $messageDry kgs\nWeights Update Successfully.",
//                                                               //text: "Weights Updated Successfully.",
//                                                             );
//                                                           });
//                                                     },
//                                                   );
//                                                 },
//                                               ),
//                                             ],
//                                           ),
//                                           subtitle: Text(
//                                             //'Date: ${listDailyCollections[index].dates}\nWet: ${listDailyCollections[index].wet} kgs, Dry: ${listDailyCollections[index].dry} kgs'),
//                                               'Date: ${_foundUsers[index]["dates"]}\nWet: ${_foundUsers[index]["wet"]} kgs, Dry: ${_foundUsers[index]["dry"]} kgs'),
//
//                                           contentPadding: const EdgeInsets.only(
//                                               top: 10, TOP: 10),
//                                           onLongPress: () {
//                                             // do something else
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Visibility(
//                     //   visible: _toggleQR_Scanner,
//                     //   maintainAnimation: true,
//                     //   maintainState: true,
//                     //   child: AnimatedOpacity(
//                     //     duration: const Duration(milliseconds: 500),
//                     //     curve: Curves.fastOutSlowIn,
//                     //     opacity: _toggleQR_Scanner ? 1 : 0,
//                     //     child: Stack(children: [
//                     //       Container(
//                     //         width: double.infinity,
//                     //         height: MediaQuery.of(context).size.width * 1.5,
//                     //         color: appWhite,
//                     //         child: Align(
//                     //             alignment: Alignment.center,
//                     //             child: Text(
//                     //               _scanNoteMessage,
//                     //               textAlign: TextAlign.center,
//                     //             )),
//                     //       ),
//                     //
//                     //       Container(
//                     //         alignment: Alignment.center,
//                     //         //padding: const EdgeInsets.all(20),
//                     //         constraints: const BoxConstraints(
//                     //           minHeight: 100,
//                     //           minWidth: double.infinity,
//                     //         ),
//                     //         child: Visibility(
//                     //           visible: _visibleScanner,
//                     //           child: ListView(
//                     //             shrinkWrap: true,
//                     //             padding: const EdgeInsets.only(
//                     //                 right: 10, left: 10),
//                     //             children: <Widget>[
//                     //               ListTile(
//                     //                 title: const Text('House Number'),
//                     //                 subtitle: Text(valueHouse),
//                     //                 trailing: const Icon(Icons.my_location),
//                     //                 onTap: () {
//                     //                   //print('goat');
//                     //                 },
//                     //               ),
//                     //               CheckboxListTile(
//                     //                 title: const Text('Not Segregated'),
//                     //                 value: timeDilation != 1.0,
//                     //                 checkColor: appGold,
//                     //                 activeColor: Colors.transparent,
//                     //                 contentPadding: const EdgeInsets.only(
//                     //                     top: 5,
//                     //                     right: 7,
//                     //                     left: 15,
//                     //                     TOP: 5),
//                     //                 onChanged: (bool? value) {
//                     //                   setState(() {
//                     //                     timeDilation = value! ? 2.0 : 1.0;
//                     //                     if (value == true) {
//                     //                       _visibleWetDryOnList = false;
//                     //                     } else {
//                     //                       _visibleWetDryOnList = true;
//                     //                     }
//                     //                   });
//                     //                 },
//                     //                 //secondary: const Icon(Icons.hourglass_empty),
//                     //               ),
//                     //               Visibility(
//                     //                 visible: _visibleWetDryOnList,
//                     //                 child: ListTile(
//                     //                   title: const Text('Wet Waste (Kg)'),
//                     //                   subtitle: Text(weightWetWaste),
//                     //                   trailing: const Icon(
//                     //                     Icons.add,
//                     //                     color: Colors.red,
//                     //                   ),
//                     //                   onTap: () async {
//                     //                     final weightWetWaste =
//                     //                         await openDialog();
//                     //                     if (weightWetWaste == null ||
//                     //                         weightWetWaste.isEmpty) {
//                     //                       return;
//                     //                     }
//                     //                     setState(() => this.weightWetWaste =
//                     //                         '$weightWetWaste Kgs');
//                     //                   },
//                     //                 ),
//                     //               ),
//                     //               Visibility(
//                     //                 visible: _visibleWetDryOnList,
//                     //                 child: ListTile(
//                     //                   title: const Text('Dry Waste (Kg)'),
//                     //                   subtitle: Text(weightDryWaste),
//                     //                   trailing: const Icon(
//                     //                     Icons.add,
//                     //                     color: Colors.red,
//                     //                   ),
//                     //                   onTap: () async {
//                     //                     final weightDryWaste =
//                     //                         await openDialog();
//                     //                     if (weightDryWaste == null ||
//                     //                         weightDryWaste.isEmpty) {
//                     //                       return;
//                     //                     }
//                     //                     setState(() => this.weightDryWaste =
//                     //                         '$weightDryWaste Kgs');
//                     //                   },
//                     //                 ),
//                     //               ),
//                     //               ListTile(
//                     //                 //title: const Text('Phone Number'),
//                     //                 subtitle: TextButton(
//                     //                   onPressed: () {
//                     //
//                     //
//                     //                     if (valueHouse != '' && weightWetWaste != 'Click To Add Weight' && weightDryWaste != 'Click To Add Weight') {
//                     //
//                     //                       // //Store User Data
//                     //                       final scannerData= DataScannerModel(
//                     //                         currentDate: currentDate.trim(),
//                     //                         enumerator: licensedCollectorAgentData.username.trim(),
//                     //                         sourceName: valueHouse.trim(),
//                     //                         segregation: _visibleWetDryOnList==true ? 'Segregated' : 'Not Segregated'.trim(),
//                     //                         wet: _visibleWetDryOnList==true ? weightWetWaste.trim() : '0 Kgs',
//                     //                         dry: _visibleWetDryOnList==true ? weightDryWaste.trim() : '0 Kgs',
//                     //                         supervisorIdentity: licensedCollectorAgentData.supervisorIdentity?.trim(),
//                     //                       );
//                     //
//                     //                       //Store Collected Data
//                     //                       DataScannerController.instance.storeScannedData(scannerData);
//                     //
//                     //                     }else{
//                     //                       Get.snackbar("Warning", "Fill all the provided fields",
//                     //                           snackPosition: SnackPosition.TOP,
//                     //                           backgroundColor: Colors.redAccent.withOpacity(0.1),
//                     //                           colorText: Colors.red);
//                     //                     }
//                     //
//                     //                     // print(
//                     //                     //     '$currentDate,'
//                     //                     //     '${licensedCollectorAgentData.username}'
//                     //                     //         '$valueHouse,'
//                     //                     //         '$_visibleWetDryOnList,'
//                     //                     //         '${_visibleWetDryOnList==true ? 'Segregated' : 'Not Segregated'},'
//                     //                     //         '${_visibleWetDryOnList==true ? weightWetWaste : 0},'
//                     //                     //         '${_visibleWetDryOnList==true ? weightDryWaste : 0},'
//                     //                     //         '${licensedCollectorAgentData.supervisorIdentity}'
//                     //                     // );
//                     //                   },
//                     //                   child: Text(
//                     //                     'Submit',
//                     //                     style: TextStyle(color: appGold),
//                     //                   ),
//                     //                 ),
//                     //               ),
//                     //             ],
//                     //           ),
//                     //         ),
//                     //       ),
//                     //     ]),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return Center(child: Text(snapshot.error.toString()));
//         } else {
//           return const Center(child: Text('Something Went Wrong'));
//         }
//       } else {
//         return const SplashPage();
//       }
//     },
//     //child: Center(child: Text('Okobo'))
//   );
// }
// }
//
//
//
