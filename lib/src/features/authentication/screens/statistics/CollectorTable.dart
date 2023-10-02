import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collectors/main.dart';
import 'package:collectors/src/features/authentication/screens/dashboard/dashboard_collector_2.dart';
import 'package:collectors/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pie_chart/pie_chart.dart';

/// This is the stateless widget that the main application instantiates.
class CollectorDataTable extends StatefulWidget {
  const CollectorDataTable({Key? key}) : super(key: key);

  @override
  _CollectorDataTableState createState() => _CollectorDataTableState();
}

class _CollectorDataTableState extends State<CollectorDataTable> {
  var usersFiltered = [];
  var users = [];
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  var wettotal = 0.0, drytotal = 0.0;

  Map<String, double> dataMap = {};

  @override
  void initState() {
    super.initState();
  }

  void _toggle() {
    setState(() {
      dataMap.addAll(
        {
          "Wet": wettotal,
        },
      );
      dataMap.addAll(
        {
          "Dry": drytotal,
        },
      );
    });
  }

  final _authRepo = Get.put(AuthenticationRepository());

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    final emailAccount = _authRepo.firebaseUser.value?.email;

    return Scaffold(
      backgroundColor: appDark,
      appBar: AppBar(
        title: const Text(
          'Collection Statistics',
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appGold,
        foregroundColor: appDark,
      ),
      body: SafeArea(
        child: Stack(
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
                      color: const Color(0xff1c162e),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24 * fem),
                        topRight: Radius.circular(24 * fem),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x4c000000),
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
              padding: const EdgeInsets.all(20),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    //color: Colors.teal.withOpacity(0.5),
                    color: appGold,
                    child: ListTile(
                      leading: Icon(
                        Icons.search,
                        color: appDark,
                      ),
                      title: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 17, color: appDark),
                          ),
                          style: TextStyle(color: appDark),
                          onChanged: (value) {
                            setState(() {
                              _searchResult = value;
                              usersFiltered = users
                                  .where((user) =>
                                      user['Enumerator']
                                          .contains(_searchResult) ||
                                      user['Wet']
                                          .toString()
                                          .contains(_searchResult) ||
                                      user['Dry']
                                          .toString()
                                          .contains(_searchResult) ||
                                      user['CurrentDate']
                                          .contains(_searchResult))
                                  .toList();

                              final double wettotal = usersFiltered.fold(
                                  0,
                                  (sum, item) =>
                                      sum + double.parse(item?['Wet']));
                              final double drytotal = usersFiltered.fold(
                                  0,
                                  (sum, item) =>
                                      sum + double.parse(item?['Dry']));

                              dataMap.addAll({
                                "Wet": wettotal,
                              });
                              dataMap.addAll({
                                "Dry": drytotal,
                              });
                              if (_searchResult == '') {
                                _toggle();
                              }
                            });
                          }),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: appDark,
                        ),
                        onPressed: () {
                          setState(() {
                            controller.clear();
                            _searchResult = '';
                            usersFiltered = users;
                            _toggle();
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('AgentScannerCollections')
                        .where("CurrentDate", isEqualTo: currentDate)
                        .where("SupervisorIdentity", isEqualTo: emailAccount)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Something went wrong");
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        // Get data from docs and convert map to List
                        final Users_result = snapshot.data?.docs
                            .map((doc) => doc.data())
                            .toList();

                        List<Map<String, dynamic>?>? documentData = snapshot
                            .data?.docs
                            .map((e) => e.data() as Map<String, dynamic>?)
                            .toList();

                        if (wettotal == 0.0 && drytotal == 0.0) {
                          wettotal = documentData!.fold(0,
                              (sum, item) => sum + double.parse(item?['Wet']));
                          drytotal = documentData!.fold(0,
                              (sum, item) => sum + double.parse(item?['Dry']));

                          users = usersFiltered = documentData!.cast<Object?>();

                          dataMap.addAll(
                            {
                              "Wet": wettotal,
                            },
                          );
                          dataMap.addAll(
                            {
                              "Dry": drytotal,
                            },
                          );
                        }

                        return Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  PieChart(
                                    dataMap: dataMap,
                                    chartRadius:
                                        MediaQuery.of(context).size.width / 5,
                                    animationDuration:
                                        const Duration(milliseconds: 1000),
                                    chartLegendSpacing: 30,
                                    // chartRadius: MediaQuery.of(context).size.width / 2.2,
                                    // colorList: colorList,
                                    initialAngleInDegree: 0,
                                    chartType: ChartType.ring,
                                    ringStrokeWidth: 10,
                                    chartValuesOptions:
                                        const ChartValuesOptions(
                                      showChartValueBackground: true,
                                      showChartValues: true,
                                      //showChartValuesInPercentage: true,
                                      showChartValuesOutside: true,
                                      decimalPlaces: 1,
                                    ),
                                    //centerText: "MY REQUESTS",
                                    legendOptions: LegendOptions(
                                      //showLegendsInRow: true,
                                      //legendPosition: LegendPosition.bottom,
                                      //showLegends: true,
                                      legendShape: BoxShape.circle,
                                      legendTextStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: appWhite),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      headingRowHeight: 50,
                                      // headingRowColor: MaterialStateColor.resolveWith(
                                      //     (states) => appWhite),
                                      border: TableBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          verticalInside: const BorderSide(
                                              width: 1,
                                              style: BorderStyle.solid,
                                              color: Colors.black),
                                          horizontalInside: const BorderSide(
                                              width: 1,
                                              style: BorderStyle.solid,
                                              color: Colors.black)),
                                      columns: <DataColumn>[
                                        DataColumn(
                                          label: Text(
                                            'Collector',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: appGold),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Wet',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: appGold),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Dry',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: appGold),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Date',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: appGold),
                                          ),
                                        ),
                                      ],
                                      rows: List.generate(
                                        usersFiltered.length,
                                        (index) => DataRow(
                                          cells: <DataCell>[
                                            DataCell(Text(
                                              usersFiltered[index]
                                                  ?['Enumerator'],
                                              style: TextStyle(color: appWhite),
                                            )),
                                            DataCell(Text(
                                              usersFiltered[index]!['Wet']
                                                  .toString(),
                                              style: TextStyle(color: appWhite),
                                            )),
                                            DataCell(Text(
                                              usersFiltered[index]!['Dry']
                                                  .toString(),
                                              style: TextStyle(color: appWhite),
                                            )),
                                            DataCell(Text(
                                              usersFiltered[index]
                                                  ?['CurrentDate'],
                                              style: TextStyle(color: appWhite),
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        );
                      }

                      return Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: appGold,
                          size: 30,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
