import 'package:responsive_supermarket/config/responsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:scrollable/exports.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_supermarket/IpAddress/database_helper.dart';

class ToysPage extends StatefulWidget {
  @override
  _ToysPageState createState() => _ToysPageState();
}

class _ToysPageState extends State<ToysPage> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'TOYS') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Toys)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class GiftPage extends StatefulWidget {
  @override
  _GiftPageState createState() => _GiftPageState();
}

class _GiftPageState extends State<GiftPage> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'GIFT') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            children: [
              Text(
                'Details(Gifts)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class StationaryPage extends StatefulWidget {
  @override
  _StationaryPageState createState() => _StationaryPageState();
}

class _StationaryPageState extends State<StationaryPage> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'STATIONARY ITEMS') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Stationary Items)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          // width: 228.0,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class StationaryPage2 extends StatefulWidget {
  @override
  _StationaryPage2State createState() => _StationaryPage2State();
}

class _StationaryPage2State extends State<StationaryPage2> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'STATIONARY ITEMS 2') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Stationary Items2)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class PlasticPage extends StatefulWidget {
  @override
  _PlasticPageState createState() => _PlasticPageState();
}

class _PlasticPageState extends State<PlasticPage> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'PLASTIC ITEMS') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Plastic Items)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class RoyalStationaryPage extends StatefulWidget {
  @override
  _RoyalStationaryPageState createState() => _RoyalStationaryPageState();
}

class _RoyalStationaryPageState extends State<RoyalStationaryPage> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'ROYAL STATIONARY') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Royal Stationary)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class RoyalStationaryPage2 extends StatefulWidget {
  @override
  _RoyalStationaryPage2State createState() => _RoyalStationaryPage2State();
}

class _RoyalStationaryPage2State extends State<RoyalStationaryPage2> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'ROYAL STATIONARY2') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Royal Stationary2)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class MasalaItemPage extends StatefulWidget {
  @override
  _MasalaItemPageState createState() => _MasalaItemPageState();
}

class _MasalaItemPageState extends State<MasalaItemPage> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'MASALAITEMS') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Masala Items)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class SriKumaranAgencyPage extends StatefulWidget {
  @override
  _SriKumaranAgencyPageState createState() => _SriKumaranAgencyPageState();
}

class _SriKumaranAgencyPageState extends State<SriKumaranAgencyPage> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'SRI KUMARAN AGENCIES') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Sri Kumaran Agencies)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class SriAgencyPage extends StatefulWidget {
  @override
  _SriAgencyPageState createState() => _SriAgencyPageState();
}

class _SriAgencyPageState extends State<SriAgencyPage> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'SRI AGENCIES') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Sri Agency)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class PulsesItemPage extends StatefulWidget {
  @override
  _PulsesItemPageState createState() => _PulsesItemPageState();
}

class _PulsesItemPageState extends State<PulsesItemPage> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'PULSES ITEMS') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Pulses Items)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class FoodItemPage extends StatefulWidget {
  @override
  _FoodItemPageState createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'FOOD ITEMS') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Food Items)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class SoapItemPage extends StatefulWidget {
  @override
  _SoapItemPageState createState() => _SoapItemPageState();
}

class _SoapItemPageState extends State<SoapItemPage> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'SOAP ITEMS') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Soap Items)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class PasteItemPage extends StatefulWidget {
  @override
  _PasteItemPageState createState() => _PasteItemPageState();
}

class _PasteItemPageState extends State<PasteItemPage> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'PASTE ITEMS') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Paste Items)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class TeaPage extends StatefulWidget {
  @override
  _TeaPageState createState() => _TeaPageState();
}

class _TeaPageState extends State<TeaPage> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'TEA') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Tea)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class ManjolaiTeaPage extends StatefulWidget {
  @override
  _ManjolaiTeaPageState createState() => _ManjolaiTeaPageState();
}

class _ManjolaiTeaPageState extends State<ManjolaiTeaPage> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'MANJOLAI TEA') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Manjolai Tea)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class VegetablesPage extends StatefulWidget {
  @override
  _VegetablesPageState createState() => _VegetablesPageState();
}

class _VegetablesPageState extends State<VegetablesPage> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'VEGETABLES') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Vegetables)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class FruitsPage extends StatefulWidget {
  @override
  _FruitsPageState createState() => _FruitsPageState();
}

class _FruitsPageState extends State<FruitsPage> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'FRUITS') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Fruits)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class Ice extends StatefulWidget {
  @override
  _IceState createState() => _IceState();
}

class _IceState extends State<Ice> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'ICE ') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Ice)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class LocalFoodPage extends StatefulWidget {
  @override
  _LocalFoodPageState createState() => _LocalFoodPageState();
}

class _LocalFoodPageState extends State<LocalFoodPage> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<Map<String, dynamic>> toyItems = [];

    for (var item in data) {
      if (item['cat'] == 'LOCAL FOOD') {
        String itemName = item['name'];
        String itemQty = item['qty'].toString();

        toyItems.add({
          'name': itemName,
          'qty': itemQty,
        });
      }
    }

    setState(() {
      tableData = toyItems;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 38, 59),
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details(Local Food)',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 42, 38, 75),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "ProductName",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 75, 156),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Qty(*)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tableData.isNotEmpty)
              ...tableData.map((data) {
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
                bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                Color? rowColor = isEvenRow
                    ? Color.fromARGB(224, 255, 255, 255)
                    : Color.fromARGB(255, 127, 161, 206);

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width *
                                  0.3 // Adjust this value as needed
                              : MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: rowColor,
                            border: Border.all(
                              color: const Color.fromARGB(221, 54, 54, 54),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dateno,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.crimsonText(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
