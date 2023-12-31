import 'package:responsive_supermarket/constants.dart';
import 'package:responsive_supermarket/controllers/MenuAppController.dart';
import 'package:responsive_supermarket/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_supermarket/IpAddress/IpScreen.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:responsive_supermarket/IpAddress/database_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SuperMarketApp',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        canvasColor: secondaryColor,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    fetchData1();
  }

  String shopNames = '';
  Future<void> fetchData1() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/ShopName/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    if (mounted) {
      setState(() {
        List<dynamic> shopNameList = data['Shop_names'];
        shopNames = shopNameList.join(', ');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkIpAndNavigate(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                // Color.fromARGB(255, 129, 207, 109),
                Colors.white,
                Colors.white,
                //Color.fromARGB(237, 252, 107, 175),
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/grocery.png",
                  height: 300.0,
                  width: 300.0,
                ),
                Text(
                  shopNames,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkIpAndNavigate(BuildContext context) async {
    String? ipAddress = await SharedPrefs.getIpAddress();
    if (ipAddress != null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                        create: (context) => MenuAppController(),
                      ),
                    ],
                    child: MainScreen(),
                  ),
                ),
              ));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => IpScreen())));
    }
  }
}
