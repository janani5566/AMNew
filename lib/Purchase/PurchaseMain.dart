import 'package:responsive_supermarket/Purchase/CurrentWeekPurchase.dart';
import 'package:responsive_supermarket/Purchase/LastMonthPurchaseSubForm.dart';
import 'package:responsive_supermarket/Purchase/LastWeekPurchaseSubForm.dart';
import 'package:responsive_supermarket/Purchase/PurchaseSubFormdetail.dart';
import 'package:responsive_supermarket/Purchase/my_tab.dart';
import 'package:responsive_supermarket/Purchase/PurchaseBill.dart';
import 'package:responsive_supermarket/config/responsive.dart';
import 'package:responsive_supermarket/screens/main/components/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_supermarket/controllers/MenuAppController.dart';
import 'package:responsive_supermarket/screens/main/main_screen.dart';

import 'CurrentMonthPurchaseSubForm.dart';

class PurchasePage extends StatefulWidget {
  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  // my tabs
  List<Widget> myTabs = const [
    // donut tab
    MyTab(
      title: 'Purchase',
      iconPath: 'assets/images/payment.png',
    ),

    // burger tab
    // MyTab(
    //   title: 'Bills',
    //   iconPath: 'assets/images/shopping_sales.png',
    // ),

    // smoothie tab
    MyTab(
      title: 'Current\nWeek',
      iconPath: 'assets/images/products.png',
    ),

    // pancake tab
    MyTab(
      title: 'Last\nWeek',
      iconPath: 'assets/images/purchase.png',
    ),

    // pizza tab
    MyTab(
      title: 'Current\nMonth',
      iconPath: 'assets/images/bill_sales.png',
    ),
    // pizza tab
    MyTab(
      title: 'Last\nMonth',
      iconPath: 'assets/images/Fruits.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: Responsive.isDesktop(context)
            ? null
            : AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.grey[800],
                      size: 36,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
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
                      );
                    },
                  ),
                ),
              ),
        body: Row(
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.grey[200], // Adjust color as needed
                  child: SideMenu(),
                ),
              ),
            Expanded(
              flex: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: Row(
                      children: [
                        Text(
                          'Purchase',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' Report',
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Icon(Icons.money),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 64, 113, 153),
                            ), // Change the color here
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 25,
                              ), // Increase the padding here
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // tab bar
                  TabBar(tabs: myTabs),

                  // tab bar view
                  Expanded(
                    child: TabBarView(
                      children: [
                        // donut page
                        TodayPurchasePage(),

                        // burger page
                        // TodayPurchaseBillPage(),

                        // smoothie page
                        PurchaseCurrentWeekPage(),

                        // pancake page
                        PurchaseLastWeekPage(),

                        // pizza page
                        PurchaseCurrentMonthPage(),

                        PurchaseLastMonthPage(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
