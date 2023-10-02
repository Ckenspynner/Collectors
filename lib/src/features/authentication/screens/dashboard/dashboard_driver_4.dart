import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collectors/main.dart';
import 'package:collectors/src/constants/image_strings.dart';
import 'package:collectors/src/features/authentication/controllers/dataScanner_controller.dart';
import 'package:collectors/src/features/authentication/controllers/truck_controller.dart';
import 'package:collectors/src/features/authentication/model/LicensedCollectorsModel.dart';
import 'package:collectors/src/features/authentication/model/TruckCollectorModel.dart';
import 'package:collectors/src/features/authentication/model/dataScannerModel.dart';
import 'package:collectors/src/features/authentication/screens/Collectors/list/CollectList.dart';
import 'package:collectors/src/features/authentication/screens/login/login_page.dart';
import 'package:collectors/src/features/authentication/screens/models/populatedailycollectionslistdata.dart';
import 'package:collectors/src/repository/authentication_repository/authentication_repository.dart';
import 'package:collectors/src/utils/utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

import 'package:qr_flutter/qr_flutter.dart';


final listDailyCollections = PopulateCollectionsHouse.listDailyCollections;
String currentDate = DateFormat('d/M/yyyy').format(DateTime.now());
String currentDate1 = DateFormat('d/M/yyyy').format(
  DateTime.now().subtract(const Duration(days: 1)),
);
String currentDate2 = DateFormat('d/M/yyyy').format(
  DateTime.now().subtract(const Duration(days: 2)),
);
double wettotal = 0.0;
double drytotal = 0.0;
bool _visible = true;
var option = "Today's";
String collectorName = 'Chrispine';
List<Map<String, dynamic>> results = [];

class GeneralDriver extends StatefulWidget {
  final bool backNav;

  const GeneralDriver({Key? key, this.restorationId, required this.backNav})
      : super(key: key);
  final String? restorationId;

  @override
  State<GeneralDriver> createState() => _GeneralDriverState();
}

class _GeneralDriverState extends State<GeneralDriver> with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2024),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        option =
            '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
        _runFilter(option);
      });
    } else {
      _runFilter(currentDate);
      option = "Today's";
    }
  }

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  List<Map<String, dynamic>> _allUsers = [];

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
      //print(results);
    } else {
      results = _allUsers
          .where((user) => user["CurrentDate"].toLowerCase() == enteredKeyword)
          .toList();
      // we use the toLowerCase() method to make it case-insensitive

      //Calculates wet weight
      wettotal =
          results.fold(0, (sum, item) => sum + double.parse(item["Wet"]));

      //Calculates dry weight
      drytotal =
          results.fold(0, (sum, item) => sum + double.parse(item["Dry"]));
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
      if (results.isEmpty) {
        _visible = false;
      } else {
        _visible = true;
      }
      if (option == currentDate) {
        option = "Today's";
      }
    });
  }

  //////////////////////////////////////////////////////////////////////////////

  String _scanBarcode = 'Unknown';
  String substring = "QR@KMFRI";
  late String splitValueWet = '',
      splitValueDry = '',
      valueGPS = '',
      valuePhone = '',
      valueDriverCollector = 'TTT';
  late Map<int, String> values;
  late TextEditingController controllerDialog;
  late String _scanNoteMessage = "Press the to right icon to scan QR code";
  String weightDryWaste = 'Click To Add Weight',
      weightWetWaste = 'Click To Add Weight';
  bool _visibleScanner = false;
  bool _visibleScannerList = true;

  @override
  void initState() {
    super.initState();

    controllerDialog = TextEditingController();
    _toggleQR_Scanner = widget.backNav;
    _toggleStatistics = !widget.backNav;
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
//barcode scanner flutter ant
    setState(() {
      _scanBarcode = barcodeScanRes;

      //Checks for incomplete QR CODE scan
      if (_scanBarcode == '-1') {
        _scanNoteMessage = "Press the to right icon to scan QR code";
        splitValueWet = '';
        splitValueDry = '';
        valueGPS = '';
        valuePhone = '';
        valueDriverCollector = '';
        _visibleScanner = false;
      } else {

        //Checks for the SECRET KEY in the QR CODE
        if (_scanBarcode.contains(substring)) {
          //Splits the QR Value to array of strings
          final split = _scanBarcode.split(',');
          //Checks if the QR value contains more than 6 parameters
          if (split.length > 4) {
            _scanNoteMessage =
                "INVALID\n\nThe QR CODE contains too many parameters";
            splitValueWet = '';
            splitValueDry = '';
            valueGPS = '';
            valuePhone = '';
            valueDriverCollector = '';
            _visibleScanner = false;
          }
          else {
            values = {for (int i = 0; i < split.length; i++) i: split[i]};
            //print(values[0]?.substring(0, 2));
            if (values[0]?.substring(0, 2) == 'LA' ||
                values[0]?.substring(0, 2) == 'SA') {
              _scanNoteMessage = '';
              _visibleScanner = true;

              valueDriverCollector = '${values[0]}';
              weightWetWaste = '${values[1]}'.substring(1,);
              weightDryWaste = '${values[2]}'.substring(1,);

              //print(values[2]);

              valueGPS = '0'; //'${values[3]} , ${values[4]}';
              valuePhone = '0'; //'${values[5]}';
            } else {
              _scanNoteMessage =
                  "INVALID\n\nThe QR CODE does not meet all the standards";
              _visibleScanner = false;
            }
            //print('$valueDriverCollector, $splitValueWet, $splitValueDry, $valueGPS, $valuePhone');
          }
        } else {
          _scanNoteMessage =
              "INVALID\n\nThe QR CODE does not meet all the standards";
          splitValueWet = '';
          splitValueDry = '';
          valueGPS = '';
          valuePhone = '';
          valueDriverCollector = '';
          _visibleScanner = false;
        }
      }
    });
  }

  //Hides widgets
  void _toggle() {
    scanQR();
    setState(() {
      _scanNoteMessage = '';
      _visibleScanner = !_visibleScanner;
    });
  }

  @override
  void dispose() {
    controllerDialog.dispose();
    super.dispose();
  }

  //////////////////////////////////////////////////////////////////////////////

  bool _toggleStatistics = false;
  bool _toggleQR_Scanner = false;
  bool _toggleQR = false;

  Future<String?> openDialog() => showDialog<String>(
      context: context,
      builder: (builder) => AlertDialog(
            title: const Text('Weight in Kgs'),
            content: TextField(
              autofocus: true,
              decoration:
                  const InputDecoration(hintText: 'Enter weight in Kgs'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: controllerDialog,
            ),
            actions: [
              TextButton(
                onPressed: submit,
                child: const Text('Submit'),
              ),
            ],
          ));

  Future<void> loader() async {
    OverlayLoadingProgress.start(context,
        gifOrImagePath: 'assets/loading.gif',
        barrierDismissible: true,
        widget: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Colors.black38,
          color: appDark,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: appGold,
                  size: 30,
                ),
              ),
            ],
          ),
        ));
    await Future.delayed(const Duration(seconds: 1));
    OverlayLoadingProgress.stop();
  }

  void submit() {
    Navigator.of(context).pop(controllerDialog.text);
    controllerDialog.clear();
  }

  bool _visibleWetDryOnList = true;
  final _authRepo = Get.put(AuthenticationRepository());
  var splitName, DriverIdentity, UserAcountName;
  var totalWetWeight = 0.0, totalDryWeight = 0.0;
  List totalCollectors = [];
  List totalStations = [];

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    //print(widget.backNav);
    final controller = Get.put(TruckCollectorController());
    final controllerScanner = Get.put(DataScannerController());
    final emailAccount = _authRepo.firebaseUser.value?.email;

    return Scaffold(
      backgroundColor: appWhite,
      appBar: _toggleStatistics
          ? AppBar(
              leading: widget.backNav
                  ? null
                  : Transform.scale(
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
                        text: 'Profile Overview',
                        style: SafeGoogleFont(
                          'Inria Sans',
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * ffem / fem,
                          letterSpacing: 0.16 * fem,
                          color: const Color(0xff1c162e),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //centerTitle: true,
              elevation: 0,
              backgroundColor: appWhite,
              foregroundColor: appDark,
              centerTitle: widget.backNav ? true : false,
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
                      icon: Icon(
                        widget.backNav ? null : Icons.notifications_none,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: widget.backNav
                          ? null
                          : () {
                              AuthenticationRepository.instance.logout();
                            },
                      icon: Icon(
                        widget.backNav
                            ? Icons.notifications_none
                            : Icons.logout_outlined,
                        color: widget.backNav ? appDark : appGold,
                      ),
                    ),
                  ]),
                ),
              ],
            )
          : AppBar(
              leading: _toggleQR
                  ? Transform.scale(
                      scale: 1,
                      child: IconButton(
                        onPressed: () =>
                            {_runFilter(currentDate), option = "Today's"},
                        icon: Icon(
                          Icons.refresh,
                          color: appDark,
                        ),
                      ),
                    )
                  : null,
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
                      _toggleQR
                          ? TextSpan(
                              text: 'Generate QR Code',
                              style: SafeGoogleFont(
                                'Inria Sans',
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.5 * ffem / fem,
                                letterSpacing: 0.16 * fem,
                                color: const Color(0xff1c162e),
                              ),
                            )
                          : _toggleQR_Scanner
                              ? TextSpan(
                                  text: 'Scan QR Code',
                                  style: SafeGoogleFont(
                                    'Inria Sans',
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * ffem / fem,
                                    letterSpacing: 0.16 * fem,
                                    color: const Color(0xff1c162e),
                                  ),
                                )
                              : TextSpan(
                                  text: '',
                                  style: SafeGoogleFont(
                                    'Inria Sans',
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * ffem / fem,
                                    letterSpacing: 0.16 * fem,
                                    color: const Color(0xff1c162e),
                                  ),
                                ),
                    ],
                  ),
                ),
              ),
              //centerTitle: true,
              elevation: 0,
              backgroundColor: appWhite,
              centerTitle: _toggleQR
                  ? widget.backNav
                      ? false
                      : true
                  : false,
              foregroundColor: appDark,
              //backgroundColor: const Color(0xfffdfdfe),
              actions: [
                _toggleQR
                    ? Container(
                        margin: const EdgeInsets.only(right: 10, top: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _restorableDatePickerRouteFuture.present();
                          },
                          icon: const Icon(
                            Icons.edit_calendar,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(right: 10, top: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Tooltip(
                          message: 'Press to scan',
                          child: IconButton(
                            onPressed: _toggle,
                            icon: const Icon(
                              Icons.qr_code_scanner_rounded,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
      bottomNavigationBar: Container(
        // autogroupjqkfBnq (CGi6PsZNmTyRLzhGMKjqKF)
        color: appWhite,
        width: double.infinity,
        height: 150 * fem,
        //color: appGreen,
        child: Stack(
          children: [
            Positioned(
              // lineL9w (I4:1812;143:612)
              left: 120 * fem,
              top: 171 * fem,
              child: Align(
                child: SizedBox(
                  width: 135 * fem,
                  height: 5 * fem,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100 * fem),
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // rectangle695TEZ (4:1813)
              left: 0 * fem,
              top: 0 * fem,
              child: Align(
                child: SizedBox(
                  width: 375 * fem,
                  height: 184 * fem,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff1c162e),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30 * fem),
                        topRight: Radius.circular(30 * fem),
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
            Positioned(
              // component8K1s (4:1814)
              left: 20 * fem,
              top: 20 * fem,
              child: GestureDetector(
                onTap: () {
                  //Get.to(() => const DailyCollectionData());
                  setState(
                    () {
                      _toggleStatistics = true;
                      _toggleQR_Scanner = false;
                      _toggleQR = false;
                    },
                  );
                  //print('object');
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  padding: EdgeInsets.fromLTRB(
                      33 * fem, 29 * fem, 33 * fem, 25.5 * fem),
                  width: 96 * fem,
                  height: 116 * fem,
                  decoration: BoxDecoration(
                    color: _toggleStatistics ? appGold : appDark,
                    borderRadius: BorderRadius.circular(12 * fem),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // component7iconszipsPXX (I4:1814;10071:8638)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 14.5 * fem),
                        width: 30 * fem,
                        height: 30 * fem,
                        child: Image.asset(
                          statistic_white,
                          width: 30 * fem,
                          height: 30 * fem,
                        ),
                      ),
                      Center(
                        // billhHK (I4:1814;10071:8637)
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              1 * fem, 0 * fem, 0 * fem, 0 * fem),
                          child: Text(
                            'Stat',
                            textAlign: TextAlign.center,
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
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              // component8QxR (4:1815)
              left: 140 * fem,
              top: 20 * fem,
              child: GestureDetector(
                onTap: () {
                  setState(
                    () {
                      _runFilter(currentDate);
                      option = "Today's";
                      _toggleStatistics = false;
                      _toggleQR_Scanner = false;
                      _toggleQR = true;
                    },
                  );
                  //print('object');
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  padding: EdgeInsets.fromLTRB(
                      22.5 * fem, 30.67 * fem, 21.5 * fem, 25.5 * fem),
                  width: 96 * fem,
                  height: 116 * fem,
                  decoration: BoxDecoration(
                    color: _toggleQR ? appGold : appDark,
                    borderRadius: BorderRadius.circular(12 * fem),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // component7iconspaymentbillGjj (I4:1815;10071:8638)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 1 * fem, 16.17 * fem),
                        width: 26.67 * fem,
                        height: 26.67 * fem,
                        child: Image.asset(
                          gen_qr_code,
                          width: 26.67 * fem,
                          height: 26.67 * fem,
                        ),
                      ),
                      Center(
                        // billAKK (I4:1815;10071:8637)
                        child: Text(
                          'Gen_QR',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont(
                            'Inria Sans',
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.1975 * ffem / fem,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              // component8Huj (4:1816)
              left: 259 * fem,
              top: 20 * fem,
              child: GestureDetector(
                onTap: () {
                  setState(
                    () {
                      _toggleStatistics = false;
                      _toggleQR_Scanner = true;
                      _toggleQR = false;
                    },
                  );
                  //print('object');
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  padding: EdgeInsets.fromLTRB(
                      34.67 * fem, 33.33 * fem, 34.67 * fem, 24 * fem),
                  width: 96 * fem,
                  height: 116 * fem,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12 * fem),
                    color: _toggleQR_Scanner ? appGold : appDark,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // component7iconsscanqrcodejWq (I4:1816;10071:8638)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 17.33 * fem),
                        width: 26.67 * fem,
                        height: 21.33 * fem,
                        child: Image.asset(
                          qr_scanner,
                          width: 26.67 * fem,
                          height: 21.33 * fem,
                        ),
                      ),
                      Center(
                        // billpHP (I4:1816;10071:8637)
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              1 * fem, 0 * fem, 0 * fem, 0 * fem),
                          child: Text(
                            'QR',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'Inria Sans',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.4285714286 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(0 * fem, 20 * fem, 0 * fem, 0 * fem),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Your elements here
              Visibility(
                visible: _toggleStatistics,
                maintainAnimation: true,
                maintainState: true,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  opacity: _toggleStatistics ? 1 : 0,
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      // overviewRhb (4:3102)

                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 0 * fem),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: appWhite,
                        //color: appGreen,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: !widget.backNav,
                            child: FutureBuilder(
                              future: controller.getTruckCollectorData(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    TruckCollectorModel truckCollectorData =
                                        snapshot.data as TruckCollectorModel;
                                    splitName =
                                        truckCollectorData.oparator.split(" ");
                                    DriverIdentity = truckCollectorData.license;
                                    UserAcountName =
                                        truckCollectorData.oparator;

                                    return Container(
                                      // hijonexQ1 (4:3105)
                                      margin: EdgeInsets.fromLTRB(
                                          20 * fem, 0 * fem, 0 * fem, 6 * fem),
                                      child: Text(
                                        'Hi, ${splitName[0]}!\nTruck: ${truckCollectorData.tagname}',
                                        style: SafeGoogleFont(
                                          'Inria Sans',
                                          fontSize: 26 * ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.8461538462 * ffem / fem,
                                          letterSpacing: 0.26 * fem,
                                          color: Color(0xff1c162e),
                                        ),
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
                                    child: LoadingAnimationWidget
                                        .staggeredDotsWave(
                                      color: appGold,
                                      size: 30,
                                    ),
                                  );
                                }
                              },
                              //child: Center(child: Text('Okobo'))
                            ),
                          ),
                          Visibility(
                            visible: !widget.backNav,
                            child: Container(
                              // whatwillyoudotoday3gM (4:3107)
                              margin: EdgeInsets.fromLTRB(
                                  20 * fem, 0 * fem, 0 * fem, 0 * fem),
                              child: Text(
                                'Collection records and updates',
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
                          ),
                          Visibility(
                            visible: !widget.backNav,
                            child: SizedBox(
                              height: 20 * fem,
                            ),
                          ),
                          FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('DriverScannerCollections')
                                .where("CurrentDate", isEqualTo: currentDate)
                                .where("EnumeratorEmail",
                                    isEqualTo: emailAccount)
                                .get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text("Something went wrong");
                              }

                              totalWetWeight = 0.0;
                              totalDryWeight = 0.0;
                              totalCollectors = [];
                              totalStations = [];

                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                for (var doc in snapshot.data!.docs) {
                                  totalWetWeight += double.parse(doc["Wet"]);
                                  totalDryWeight += double.parse(doc["Dry"]);

                                  if (doc["SourceName"].substring(0, 2) ==
                                      'SA') {
                                    totalStations.add(doc["SourceName"]);
                                  }
                                  if (doc["SourceName"].substring(0, 2) ==
                                      'LA') {
                                    totalCollectors.add(doc["SourceName"]);
                                  }
                                }
                                // print(totalStations.toSet().length);
                                // print(totalCollectors.toSet().length);
                                //return const Text('data');

                                return Container(
                                  //color: appGold,
                                  // autogroup2zxf9UV (CGiGta58ayzBN6oaui2ZXF)
                                  padding: EdgeInsets.fromLTRB(
                                      20 * fem,
                                      !widget.backNav ? 0 * fem : 0 * fem,
                                      20 * fem,
                                      65 * fem),
                                  width: double.infinity,
                                  //height: MediaQuery.of(context).size.height,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // autogroupccz5oxM (CGiECUtYo34uURMAt3Ccz5)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 25 * fem),
                                        width: double.infinity,
                                        height: 158 * fem,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // cardtokenbonus7y3 (4:3109)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem),
                                              padding: EdgeInsets.fromLTRB(
                                                  13 * fem,
                                                  15 * fem,
                                                  14 * fem,
                                                  20 * fem),
                                              width: 335 * fem,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Color(0xff1c162e),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12 * fem),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0x7f7d64ff),
                                                    offset: Offset(
                                                        0 * fem, 8 * fem),
                                                    blurRadius: 10 * fem,
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // autogroupktjooay (CGiETUTZsdonGjVu3ykTjo)
                                                    margin: EdgeInsets.fromLTRB(
                                                        3 * fem,
                                                        0 * fem,
                                                        0.95 * fem,
                                                        18 * fem),
                                                    width: double.infinity,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          // dashboardixq (4:3110)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  //45.05 * fem,
                                                                  0 * fem),
                                                          child: Text(
                                                            'Collections',
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
                                                        Container(
                                                          // arrowdown338S89 (4:3111)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  3 * fem,
                                                                  0 * fem,
                                                                  0 * fem),
                                                          width: 12 * fem,
                                                          height: 6.6 * fem,
                                                          child: Image.asset(
                                                            down_arrow,
                                                            width: 12 * fem,
                                                            height: 6.6 * fem,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    // autogroupznn5kuX (CGiEaDmKroe5LB4pq3znn5)
                                                    margin: EdgeInsets.fromLTRB(
                                                        6 * fem,
                                                        0 * fem,
                                                        5 * fem,
                                                        7 * fem),
                                                    width: double.infinity,
                                                    height: 67 * fem,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Container(
                                                          // rectangle477nrD (4:3117)
                                                          width: 5 * fem,
                                                          height: 22 * fem,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8 * fem),
                                                            color: const Color(
                                                                0xffffd035),
                                                          ),
                                                        ),
                                                        Container(
                                                          // rectangle479J3s (4:3118)
                                                          width: 5 * fem,
                                                          height: 36 * fem,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8 * fem),
                                                            color: const Color(
                                                                0xffffd035),
                                                          ),
                                                        ),
                                                        Container(
                                                          // rectangle481SA5 (4:3119)
                                                          width: 5 * fem,
                                                          height: 45 * fem,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8 * fem),
                                                            color: const Color(
                                                                0xffffd035),
                                                          ),
                                                        ),
                                                        Container(
                                                          // rectangle4836VX (4:3120)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  //23 * fem,
                                                                  0 * fem),
                                                          width: 5 * fem,
                                                          height: 67 * fem,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8 * fem),
                                                            color: const Color(
                                                                0xffffd035),
                                                          ),
                                                        ),
                                                        Container(
                                                          // rectangle4852PB (4:3121)
                                                          width: 5 * fem,
                                                          height: 51 * fem,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8 * fem),
                                                            color: const Color(
                                                                0xffffd035),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    // autogroupmnfbmrZ (CGiEuDDgZRuicJbDK7Mnfb)
                                                    width: double.infinity,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                            'Mar',
                                                            style:
                                                                SafeGoogleFont(
                                                              'Dosis',
                                                              fontSize:
                                                                  11 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 1.265 *
                                                                  ffem /
                                                                  fem,
                                                              letterSpacing:
                                                                  0.11 * fem,
                                                              color: const Color(
                                                                  0xffffffff),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          // aprb4u (4:3113)
                                                          // margin: EdgeInsets.fromLTRB(
                                                          //     0 * fem,
                                                          //     0 * fem,
                                                          //     11 * fem,
                                                          //     0 * fem),
                                                          child: Text(
                                                            'Apr',
                                                            style:
                                                                SafeGoogleFont(
                                                              'Dosis',
                                                              fontSize:
                                                                  11 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 1.265 *
                                                                  ffem /
                                                                  fem,
                                                              letterSpacing:
                                                                  0.11 * fem,
                                                              color: const Color(
                                                                  0xffffffff),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          // mayi9X (4:3114)
                                                          // margin: EdgeInsets.fromLTRB(
                                                          //     0 * fem,
                                                          //     0 * fem,
                                                          //     10 * fem,
                                                          //     0 * fem),
                                                          child: Text(
                                                            'May',
                                                            style:
                                                                SafeGoogleFont(
                                                              'Dosis',
                                                              fontSize:
                                                                  11 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 1.265 *
                                                                  ffem /
                                                                  fem,
                                                              letterSpacing:
                                                                  0.11 * fem,
                                                              color: Color(
                                                                  0xffffffff),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          // junqjw (4:3115)
                                                          // margin: EdgeInsets.fromLTRB(
                                                          //     0 * fem,
                                                          //     0 * fem,
                                                          //     12 * fem,
                                                          //     0 * fem),
                                                          child: Text(
                                                            'Jun',
                                                            style:
                                                                SafeGoogleFont(
                                                              'Dosis',
                                                              fontSize:
                                                                  11 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 1.265 *
                                                                  ffem /
                                                                  fem,
                                                              letterSpacing:
                                                                  0.11 * fem,
                                                              color: const Color(
                                                                  0xffffffff),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          // julyLM (4:3116)
                                                          'Jul',
                                                          style: SafeGoogleFont(
                                                            'Dosis',
                                                            fontSize: 11 * ffem,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.265 *
                                                                ffem /
                                                                fem,
                                                            letterSpacing:
                                                                0.11 * fem,
                                                            color: const Color(
                                                                0xffffffff),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        // autogroupbrrygAD (CGiFUwkUVH5BuWRrCUbRry)
                                        width: double.infinity,
                                        height: 158 * fem,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // cardtokenbonusdbF (4:3122)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  25 * fem,
                                                  0 * fem),
                                              padding: EdgeInsets.fromLTRB(
                                                  16 * fem,
                                                  16 * fem,
                                                  14.95 * fem,
                                                  16 * fem),
                                              width: 155 * fem,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: const Color(0xffffffff),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12 * fem),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0x14404040),
                                                    offset: Offset(
                                                        0 * fem, 8 * fem),
                                                    blurRadius: 10 * fem,
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // autogroupsudjRLm (CGiFMXoAESKS6mJK33sudj)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        41 * fem),
                                                    width: double.infinity,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          // invoicektq (4:3132)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  //66.97 * fem,
                                                                  0 * fem),
                                                          child: Text(
                                                            'Stations',
                                                            style:
                                                                SafeGoogleFont(
                                                              'Inria Sans',
                                                              fontSize:
                                                                  14 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              height:
                                                                  1.4285714286 *
                                                                      ffem /
                                                                      fem,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          // arrowdown338U49 (4:3135)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem),
                                                          width: 11.68 * fem,
                                                          height: 6.6 * fem,
                                                          child: Image.asset(
                                                            down_arrow,
                                                            width: 11.68 * fem,
                                                            height: 6.6 * fem,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  !widget.backNav
                                                      ? Text(
                                                          // Bz9 (4:3134)
                                                          '${totalStations.toSet().length}',
                                                          style: SafeGoogleFont(
                                                            'Inria Sans',
                                                            fontSize: 26 * ffem,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            height:
                                                                1.8461538462 *
                                                                    ffem /
                                                                    fem,
                                                            letterSpacing:
                                                                0.26 * fem,
                                                            color: const Color(
                                                                0xff1c162e),
                                                          ),
                                                        )
                                                      : Text(
                                                          // Bz9 (4:3134)
                                                          '10',
                                                          style: SafeGoogleFont(
                                                            'Inria Sans',
                                                            fontSize: 26 * ffem,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            height:
                                                                1.8461538462 *
                                                                    ffem /
                                                                    fem,
                                                            letterSpacing:
                                                                0.26 * fem,
                                                            color: const Color(
                                                                0xff1c162e),
                                                          ),
                                                        ),
                                                  Text(
                                                    // projectandinvoice8uP (4:3133)
                                                    'Total Stations Visited',
                                                    style: SafeGoogleFont(
                                                      'Inria Sans',
                                                      fontSize: 12 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.3333333333 *
                                                          ffem /
                                                          fem,
                                                      letterSpacing: 0.12 * fem,
                                                      color: const Color(
                                                          0xff1c162e),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // cardtokenbonus5eH (4:3131)
                                              padding: EdgeInsets.fromLTRB(
                                                  16 * fem,
                                                  15 * fem,
                                                  15.34 * fem,
                                                  18 * fem),
                                              width: 155 * fem,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: const Color(0xffffffff),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12 * fem),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0x14404040),
                                                    offset: Offset(
                                                        0 * fem, 8 * fem),
                                                    blurRadius: 10 * fem,
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // autogroupsudjRLm (CGiFMXoAESKS6mJK33sudj)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        41 * fem),
                                                    width: double.infinity,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          // invoicektq (4:3132)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  //66.97 * fem,
                                                                  0 * fem),
                                                          child: Text(
                                                            'Collectors',
                                                            style:
                                                                SafeGoogleFont(
                                                              'Inria Sans',
                                                              fontSize:
                                                                  14 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              height:
                                                                  1.4285714286 *
                                                                      ffem /
                                                                      fem,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          // arrowdown338U49 (4:3135)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem),
                                                          width: 11.68 * fem,
                                                          height: 6.6 * fem,
                                                          child: Image.asset(
                                                            down_arrow,
                                                            width: 11.68 * fem,
                                                            height: 6.6 * fem,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  !widget.backNav
                                                      ? Text(
                                                          // Bz9 (4:3134)
                                                          '${totalCollectors.toSet().length}',
                                                          style: SafeGoogleFont(
                                                            'Inria Sans',
                                                            fontSize: 26 * ffem,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            height:
                                                                1.8461538462 *
                                                                    ffem /
                                                                    fem,
                                                            letterSpacing:
                                                                0.26 * fem,
                                                            color: Color(
                                                                0xff1c162e),
                                                          ),
                                                        )
                                                      : Text(
                                                          // Bz9 (4:3134)
                                                          '136',
                                                          style: SafeGoogleFont(
                                                            'Inria Sans',
                                                            fontSize: 26 * ffem,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            height:
                                                                1.8461538462 *
                                                                    ffem /
                                                                    fem,
                                                            letterSpacing:
                                                                0.26 * fem,
                                                            color: const Color(
                                                                0xff1c162e),
                                                          ),
                                                        ),
                                                  Text(
                                                    // projectandinvoice8uP (4:3133)
                                                    'Total Collectors',
                                                    style: SafeGoogleFont(
                                                      'Inria Sans',
                                                      fontSize: 12 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.3333333333 *
                                                          ffem /
                                                          fem,
                                                      letterSpacing: 0.12 * fem,
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
                                        height: 20 * fem,
                                      ),
                                      SizedBox(
                                        // autogroupbrrygAD (CGiFUwkUVH5BuWRrCUbRry)
                                        width: double.infinity,
                                        height: 158 * fem,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // cardtokenbonusdbF (4:3122)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  25 * fem,
                                                  0 * fem),
                                              padding: EdgeInsets.fromLTRB(
                                                  16 * fem,
                                                  16 * fem,
                                                  14.95 * fem,
                                                  16 * fem),
                                              width: 155 * fem,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: const Color(0xffffffff),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12 * fem),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0x14404040),
                                                    offset: Offset(
                                                        0 * fem, 8 * fem),
                                                    blurRadius: 10 * fem,
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // autogroupsudjRLm (CGiFMXoAESKS6mJK33sudj)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        41 * fem),
                                                    width: double.infinity,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          // invoicektq (4:3132)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  66.97 * fem,
                                                                  0 * fem),
                                                          child: Text(
                                                            'Wet',
                                                            style:
                                                                SafeGoogleFont(
                                                              'Inria Sans',
                                                              fontSize:
                                                                  14 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              height:
                                                                  1.4285714286 *
                                                                      ffem /
                                                                      fem,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          // arrowdown338U49 (4:3135)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem),
                                                          width: 11.68 * fem,
                                                          height: 6.6 * fem,
                                                          child: Image.asset(
                                                            down_arrow,
                                                            width: 11.68 * fem,
                                                            height: 6.6 * fem,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    // Bz9 (4:3134)
                                                    '$totalWetWeight Kgs',
                                                    style: SafeGoogleFont(
                                                      'Inria Sans',
                                                      fontSize: 26 * ffem,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 1.8461538462 *
                                                          ffem /
                                                          fem,
                                                      letterSpacing: 0.26 * fem,
                                                      color: const Color(
                                                          0xff1c162e),
                                                    ),
                                                  ),
                                                  Text(
                                                    // projectandinvoice8uP (4:3133)
                                                    'Total Wet Weight',
                                                    style: SafeGoogleFont(
                                                      'Inria Sans',
                                                      fontSize: 12 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.3333333333 *
                                                          ffem /
                                                          fem,
                                                      letterSpacing: 0.12 * fem,
                                                      color: const Color(
                                                          0xff1c162e),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // cardtokenbonus5eH (4:3131)
                                              padding: EdgeInsets.fromLTRB(
                                                  16 * fem,
                                                  15 * fem,
                                                  15.34 * fem,
                                                  18 * fem),
                                              width: 155 * fem,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: const Color(0xffffffff),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12 * fem),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0x14404040),
                                                    offset: Offset(
                                                        0 * fem, 8 * fem),
                                                    blurRadius: 10 * fem,
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // autogroupsudjRLm (CGiFMXoAESKS6mJK33sudj)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        41 * fem),
                                                    width: double.infinity,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          // invoicektq (4:3132)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  66.97 * fem,
                                                                  0 * fem),
                                                          child: Text(
                                                            'Dry',
                                                            style:
                                                                SafeGoogleFont(
                                                              'Inria Sans',
                                                              fontSize:
                                                                  14 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              height:
                                                                  1.4285714286 *
                                                                      ffem /
                                                                      fem,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          // arrowdown338U49 (4:3135)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem),
                                                          width: 11.68 * fem,
                                                          height: 6.6 * fem,
                                                          child: Image.asset(
                                                            down_arrow,
                                                            width: 11.68 * fem,
                                                            height: 6.6 * fem,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    // Bz9 (4:3134)
                                                    '$totalDryWeight Kgs',
                                                    style: SafeGoogleFont(
                                                      'Inria Sans',
                                                      fontSize: 26 * ffem,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 1.8461538462 *
                                                          ffem /
                                                          fem,
                                                      letterSpacing: 0.26 * fem,
                                                      color: Color(0xff1c162e),
                                                    ),
                                                  ),
                                                  Text(
                                                    // projectandinvoice8uP (4:3133)
                                                    'Total Dry Weight',
                                                    style: SafeGoogleFont(
                                                      'Inria Sans',
                                                      fontSize: 12 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.3333333333 *
                                                          ffem /
                                                          fem,
                                                      letterSpacing: 0.12 * fem,
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
                                );
                              }

                              return SizedBox(
                                height: MediaQuery.of(context).size.height / 2,
                                child: Center(
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                    color: appGold,
                                    size: 30,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _toggleQR,
                maintainAnimation: true,
                maintainState: true,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  opacity: _toggleQR ? 1 : 0,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      width: double.infinity,
                      child: FutureBuilder(
                        future: widget.backNav == true
                            ? FirebaseFirestore.instance
                                .collection('StationScannerCollections')
                                .where("CurrentDate", isEqualTo: currentDate)
                                .where("EnumeratorEmail",
                                    isEqualTo: emailAccount)
                                .get()
                            : FirebaseFirestore.instance
                                .collection('DriverScannerCollections')
                                .where("CurrentDate", isEqualTo: currentDate)
                                .where("EnumeratorEmail",
                                    isEqualTo: emailAccount)
                                .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Something went wrong");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // Get data from docs and convert map to List
                            final _allUsers_result = snapshot.data?.docs
                                .map((doc) => doc.data())
                                .toList();

                            _allUsers = ((_allUsers_result)
                                ?.map((e) => e as Map<String, dynamic>)!
                                .toList())!;

                            return Container(
                              // overviewRhb (4:3102)

                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 0 * fem),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: appWhite,
                                //color: appGreen,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 50 * fem,
                                  ),
                                  QrImageView(
                                    data: //encryptWithAES(key, '$DriverIdentity,W$wettotal,D$drytotal,QR@KMFRI').base64,
                                        '$DriverIdentity,W$wettotal,D$drytotal,QR@KMFRI',
                                    version: QrVersions.auto,
                                    size: 300 * fem,
                                    backgroundColor: Colors.white,
                                    //data: '$_toggleQR',
                                  ),
                                  Visibility(
                                    visible: widget.backNav,
                                    child: SizedBox(
                                      height: 20 * fem,
                                      child: Text(
                                        'Scan to transfer data.',
                                        style: SafeGoogleFont(
                                          'Inria Sans',
                                          fontSize: 12 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3333333333 * ffem / fem,
                                          letterSpacing: 0.12 * fem,
                                          color: Color(0xff1c162e),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: widget.backNav,
                                    child: SizedBox(
                                      height: 20 * fem,
                                    ),
                                  ),
                                  SizedBox(
                                    //height: 40 * fem,
                                    child: _visible
                                        ? Text(
                                            // projectandinvoice8uP (4:3133)
                                            '$option Collection Data',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'Inria Sans',
                                              fontSize: 20 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3333333333 * ffem / fem,
                                              letterSpacing: 0.12 * fem,
                                              color: Color(0xff1c162e),
                                            ),
                                          )
                                        : Text(
                                            // projectandinvoice8uP (4:3133)
                                            '$option\nNo Record Found ',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'Inria Sans',
                                              fontSize: 20 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3333333333 * ffem / fem,
                                              letterSpacing: 0.12 * fem,
                                              color: Color(0xff1c162e),
                                            ),
                                          ),
                                  ),
                                  SizedBox(
                                    height: 20 * fem,
                                  ),
                                  Container(
                                    color: appWhite,
                                    constraints: BoxConstraints(
                                      minHeight: 100,
                                      maxHeight:
                                          MediaQuery.of(context).size.height /
                                              1.6,
                                      minWidth: double.infinity,
                                    ),
                                    child: ListView(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      children: <Widget>[
                                        ...List.generate(
                                          _foundUsers.length,
                                          // Replace this with 1, 2 to see min height works.
                                          (index) => ListTile(
                                            leading: CircleAvatar(
                                              radius: 30,
                                              backgroundColor: appDark,
                                              child: Text(
                                                //listDailyCollections[index].house.substring(3),
                                                _foundUsers[index]["SourceName"]
                                                            .substring(0, 2) ==
                                                        'SA'
                                                    ? 'S'
                                                    : 'C',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'ProximaNova',
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 20.0),
                                              ),
                                              //backgroundImage: AssetImage(listDailyCollections[index].pictures),
                                            ),
                                            title: Text(
                                              _foundUsers[index]["SourceName"]
                                                  .substring(0, 2) ==
                                                  'SA'
                                                  ? _foundUsers[index]["SourceName"].substring(2,)
                                                  : _foundUsers[index]["SourceName"],
                                              style: TextStyle(color: appDark),
                                            ),
                                            //listDailyCollections[index].house),
                                            trailing: Wrap(
                                              spacing: -16,
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.edit_note,
                                                      color: appGold),
                                                  onPressed: () {},
                                                ),
                                              ],
                                            ),
                                            subtitle: Text(
                                                //'Date: ${listDailyCollections[index].dates}\nWet: ${listDailyCollections[index].wet} kgs, Dry: ${listDailyCollections[index].dry} kgs'),
                                                'Date: ${_foundUsers[index]["CurrentDate"]}\nWet: ${_foundUsers[index]["Wet"]} kgs, Dry: ${_foundUsers[index]["Dry"]} kgs'),

                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                            onLongPress: () {
                                              // do something else
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: appGold,
                                size: 30,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _toggleQR_Scanner,
                maintainAnimation: true,
                maintainState: true,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  opacity: _toggleQR_Scanner ? 1 : 0,
                  child: Stack(children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width * 1.5,
                      color: appWhite,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            _scanNoteMessage,
                            textAlign: TextAlign.center,
                          )),
                    ),
                    Container(
                      alignment: Alignment.center,
                      //padding: const EdgeInsets.all(20),
                      constraints: const BoxConstraints(
                        minHeight: 100,
                        minWidth: double.infinity,
                      ),
                      child: Visibility(
                        visible: _visibleScanner,
                        child: ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          children: <Widget>[
                            ListTile(
                              title: const Text('Identifier'),
                              subtitle: Text(valueDriverCollector.substring(0,2) == 'LA'?valueDriverCollector:valueDriverCollector.substring(0,2) == 'SA'?valueDriverCollector.substring(2,):''),
                              trailing: const Icon(Icons.my_location),
                              onTap: () {
                                //print('goat');
                              },
                            ),
                            ListTile(
                              title: const Text('Wet Waste (Kg)'),
                              subtitle: Text(weightWetWaste),
                              trailing: const Icon(
                                Icons.add,
                                color: Colors.red,
                              ),
                              onTap: () async {
                                final weightWetWaste = await openDialog();
                                if (weightWetWaste == null ||
                                    weightWetWaste.isEmpty) {
                                  return;
                                }
                                setState(
                                    () => this.weightWetWaste = weightWetWaste);
                              },
                            ),
                            ListTile(
                              title: const Text('Dry Waste (Kg)'),
                              subtitle: Text(weightDryWaste),
                              trailing: const Icon(
                                Icons.add,
                                color: Colors.red,
                              ),
                              onTap: () async {
                                final weightDryWaste = await openDialog();
                                if (weightDryWaste == null ||
                                    weightDryWaste.isEmpty) {
                                  return;
                                }
                                setState(
                                    () => this.weightDryWaste = weightDryWaste);
                              },
                            ),
                            ListTile(
                              //title: const Text('Phone Number'),
                              subtitle: TextButton(
                                onPressed: () {
                                  //valueDriverCollector = 'SA0913232402';
                                  if (valueDriverCollector != '') {
                                    //Store User Data
                                    final scannerData = DataScannerModel(
                                      currentDate: currentDate.trim(),
                                      enumerator: UserAcountName.trim(),
                                      sourceName: valueDriverCollector.trim(),
                                      wet: weightWetWaste.trim(),
                                      dry: weightDryWaste.trim(),
                                      enumeratorEmail: emailAccount?.trim(),
                                    );

                                    //Store Collected Data
                                    DataScannerController.instance
                                        .storeDriverScannedData(scannerData);

                                    weightDryWaste = 'Click To Add Weight';
                                    weightWetWaste = 'Click To Add Weight';
                                    valueDriverCollector = 'TTT';

                                    Future.delayed(Duration.zero, () async {
                                      loader();
                                    });
                                  } else {
                                    Get.snackbar("Warning",
                                        "Fill all the provided fields",
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor:
                                            Colors.redAccent.withOpacity(0.1),
                                        colorText: Colors.red);
                                  }

                                  // print(
                                  //     '$currentDate,'
                                  //     '${widget.backNav == true ? widget.collectorName : UserAcountName.trim()},'
                                  //         '$valueDriverCollector,'
                                  //         '$_visibleWetDryOnList,'
                                  //         '${_visibleWetDryOnList==true ? 'Segregated' : 'Not Segregated'},'
                                  //         '${_visibleWetDryOnList==true ? weightWetWaste : 0},'
                                  //         '${_visibleWetDryOnList==true ? weightDryWaste : 0},'
                                  //         '${widget.backNav == true ? emailAccount : DriverIdentity},'
                                  //         '$emailAccount'
                                  // );

                                  setState(() {
                                    _scanNoteMessage =
                                        "Press the to right icon to scan QR code";
                                    _visibleScanner = !_visibleScanner;
                                    //_visibleWetDryOnList = !_visibleWetDryOnList;
                                  });
                                  //_visibleWetDryOnList = !_visibleWetDryOnList;
                                },
                                child: Text(
                                  'Submit',
                                  style: TextStyle(color: appGold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
