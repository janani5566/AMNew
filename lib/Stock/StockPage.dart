// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:SuperMarket/dashboard.dart';
// import 'package:SuperMarket/Stock/StockPageDetailsSubForm.dart';
// import 'package:SuperMarket/ApiCall.dart';
// import 'package:SuperMarket/component/infoCard.dart';

// class StockPage extends StatefulWidget {
//   @override
//   _StockPageState createState() => _StockPageState();
// }

// class _StockPageState extends State<StockPage> {
//   List<String> itemTitles = [];
//   List<int> categoryData = [];
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

// Future<void> fetchData() async {
//   String apiUrl = 'http://$IpAddress/toStockCatWise/';
//   http.Response response = await http.get(Uri.parse(apiUrl));
//   var data = json.decode(response.body);
//   List<String> titles = [];
//   List<int> dataWithAmount = []; // Changed the type to List<int>

//   for (var item in data) {
//     titles.add(item['cat']);
//     // Convert the 'total_qty' value from String to int using int.parse()
//     dataWithAmount.add(item['total_qty'].toInt());
//   }

//   setState(() {
//     itemTitles = titles;
//     categoryData = dataWithAmount;
//   });
// }

//   void navigateToDetailPage(String title) {
//     // Navigate to the detail page based on the selected category title
//     if (title == 'TOYS') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ToysPage(),
//         ),
//       );
//     } else if (title == 'GIFT') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => GiftPage(),
//         ),
//       );
//     } else if (title == 'STATIONARY ITEMS') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => StationaryPage(),
//         ),
//       );
//     } else if (title == 'STATIONARY ITEMS 2') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => StationaryPage2(),
//         ),
//       );
//     } else if (title == 'PLASTIC ITEMS') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PlasticPage(),
//         ),
//       );
//     } else if (title == 'ROYAL STATIONARY') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => RoyalStationaryPage(),
//         ),
//       );
//     } else if (title == 'ROYAL STATIONARY2') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => RoyalStationaryPage2(),
//         ),
//       );
//     } else if (title == 'MASALAITEMS') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => MasalaItemPage(),
//         ),
//       );
//     } else if (title == 'SRI KUMARAN AGENCIES') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => SriKumaranAgencyPage(),
//         ),
//       );
//     } else if (title == 'SRI AGENCIES') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => SriAgencyPage(),
//         ),
//       );
//     } else if (title == 'PULSES ITEMS') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PulsesItemPage(),
//         ),
//       );
//     } else if (title == 'FOOD ITEMS') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => FoodItemPage(),
//         ),
//       );
//     } else if (title == 'SOAP ITEMS') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => SoapItemPage(),
//         ),
//       );
//     } else if (title == 'PASTE ITEMS') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PasteItemPage(),
//         ),
//       );
//     } else if (title == 'TEA') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => TeaPage(),
//         ),
//       );
//     } else if (title == 'MANJOLAI TEA') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ManjolaiTeaPage(),
//         ),
//       );
//     } else if (title == 'VEGETABLES') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => VegetablesPage(),
//         ),
//       );
//     } else if (title == 'FRUITS') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => FruitsPage(),
//         ),
//       );
//     } else if (title == 'ICE ') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => Ice(),
//         ),
//       );
//     } else if (title == 'LOCAL FOOD') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => LocalFoodPage(),
//         ),
//       );
//     }
//   }

//   Map<String, String> categoryImages = {
//     'TOYS':
//         'https://indian-retailer.s3.ap-south-1.amazonaws.com/s3fs-public/2022-07/44289962475_e5c5209506_b.jpg',
//     'GIFT':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDTB5ybEUEu4yJEdpokZpc4lhjTizqwlMpCw&usqp=CAU',
//     'STATIONARY ITEMS':
//         'https://media.gettyimages.com/id/802352810/photo/top-view-of-a-large-group-of-school-or-office-supplies-on-wooden-table.jpg?s=612x612&w=gi&k=20&c=ADCobOWMlIJalCHffUF_fERuo5AZ-EeDW-lwDw-grX8=',
//     'STATIONARY ITEMS 2':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwDjT7n5hvXVSdQlzoweP5NJdRQhw_YPOAqg&usqp=CAU',
//     'PLASTIC ITEMS':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyi-eSRN7suQNZSAWMQUc8AFD156haqY8lTg&usqp=CAU',
//     'ROYAL STATIONARY':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgXlDP0-1ElBje4JX8fEUfJFKoArI-b9YKGw&usqp=CAU',
//     'ROYAL STATIONARY2':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZupyC8ayDLEHziTL8eHb3N0e9qFXAgXLRSA&usqp=CAU',
//     'MASALAITEMS':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDVG6C8c8uEowqU2u4qe3SrGmRAJ_9-L1BmA&usqp=CAU',
//     'SRI KUMARAN AGENCIES':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3tt6ZxPqBlOEjVCGO3R04WK1j63rhxQmeHQ&usqp=CAU',
//     'SRI AGENCIES':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRopuojyEfGsi9H7HQAxktmiMTMUG-Nqq7t2A&usqp=CAU',
//     'PULSES ITEMS':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUnhH4KpJM9Mvhs38vYqhruGiB76cxIA8d2Q&usqp=CAU',
//     'FOOD ITEMS':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSicywS9T9mi7f_6gKsNnhxNSf3mbhL7flZgw&usqp=CAU',
//     'SOAP ITEMS':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTr9oYvsi9_peeAYM4hOfpJhsK86u3_Od8zVP74pcP_l65zJ6zMLaPV1gmzje1dAsCYR0&usqp=CAU',
//     'PASTE ITEMS':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOEklFEZ6LXGQqI8Dh3dToynDBGoiSXFjHlg&usqp=CAU',
//     'TEA':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdE4m2Yl620UausGXqOvkAXFmpzxVTKgfZcg&usqp=CAU',
//     'MANJOLAI TEA':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBUMXVcudrmEGNYfnI5VnLm3KMdtmYn-Rukw&usqp=CAU',
//     'VEGETABLES':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpyRUHEA6EaCoQ6ogqTZQvNxnx8qcU36dDw&usqp=CAU',
//     'FRUITS':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzxXJzXhROAO1nVLIoJjkU_sNPhKHAzSzcTg&usqp=CAU',
//     'ICE ':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThgA47GHL35jZlaar8KhowAFHlzGWNQ2CDrg&usqp=CAU',
//     'LOCAL FOOD':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBp4pdrqb8FrrHHYVU0g8DYCkXoy0IcYE5ow&usqp=CAU',
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.red[200],
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Stock Category',
//           style: GoogleFonts.crimsonText(
//             color: Colors.white,
//             fontSize: 21,
//             fontWeight: FontWeight.w800,
//           ),
//         ),
//         leading: IconButton(
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => Dashboard()));
//             },
//             icon: Icon(Icons.arrow_back, color: Colors.white)),
//         backgroundColor: Color.fromARGB(255, 119, 211, 44),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           ButtonWidget(),
//           Expanded(
//             child: Container(
//               width: 430.0, // Set the desired width here
//               child: ListView.builder(
//                 itemCount: itemTitles.length,
//                 itemBuilder: (context, index) {
//                   String title = itemTitles[index];
//                   String? imagePath = categoryImages[title];
//                   int? amount = categoryData[index];

//                   return GestureDetector(
//                     onTap: () {
//                       navigateToDetailPage(title);
//                     },
//                     child: Center(
//                       child: Card(
//                         margin: EdgeInsets.only(top: 28.0, left: 10.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         elevation: 10,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           child: ListTile(
//                             leading: imagePath != null
//                                 ? Container(
//                                     width: 40,
//                                     height: 40,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(8.0),
//                                       image: DecorationImage(
//                                         image: Image.network(imagePath).image,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   )
//                                 : SizedBox(), // Placeholder for image if path is not provided
//                             title: Text(
//                               title,
//                               style: GoogleFonts.crimsonText(
//                                 color: Colors.black,
//                                 fontSize: 21,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                             ),
//                             subtitle: Text(
//                               amount != null ? 'Total Quantity: $amount' : '',
//                               style: GoogleFonts.crimsonText(
//                                 color: Colors.black,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w300,
//                               ), // Display the category data in the subtitle
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/animation.dart';
import 'package:responsive_supermarket/Stock/StockPageDetailsSubForm.dart';
import 'package:responsive_supermarket/IpAddress/database_helper.dart';
import 'package:provider/provider.dart';
import 'package:responsive_supermarket/controllers/MenuAppController.dart';
import 'package:responsive_supermarket/screens/main/main_screen.dart';
import 'package:responsive_supermarket/config/responsive.dart';
import 'package:responsive_supermarket/screens/main/components/side_menu.dart';

void main() => runApp(StockPage());

class StockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class FoodItem {
  final String imgPath;
  final String foodName;
  final String price;

  FoodItem({
    required this.imgPath,
    required this.foodName,
    required this.price,
  });
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List<String> itemTitles = [];
  List<int> categoryData = [];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    fetchData();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _controller.forward();
  }

  Future<void> fetchData() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/toStockCatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<String> titles = [];
    List<int> dataWithAmount = [];

    for (var item in data) {
      titles.add(item['cat']);
      dataWithAmount.add(item['total_qty'].toInt());
    }

    setState(() {
      itemTitles = titles;
      categoryData = dataWithAmount;
    });
  }

  void navigateToDetailPage(String title) {
    // Navigation logic here...
    // Navigate to the detail page based on the selected category title
    if (title == 'TOYS') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ToysPage(),
        ),
      );
    } else if (title == 'GIFT') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GiftPage(),
        ),
      );
    } else if (title == 'STATIONARY ITEMS') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StationaryPage(),
        ),
      );
    } else if (title == 'STATIONARY ITEMS 2') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StationaryPage2(),
        ),
      );
    } else if (title == 'PLASTIC ITEMS') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlasticPage(),
        ),
      );
    } else if (title == 'ROYAL STATIONARY') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RoyalStationaryPage(),
        ),
      );
    } else if (title == 'ROYAL STATIONARY2') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RoyalStationaryPage2(),
        ),
      );
    } else if (title == 'MASALAITEMS') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MasalaItemPage(),
        ),
      );
    } else if (title == 'SRI KUMARAN AGENCIES') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SriKumaranAgencyPage(),
        ),
      );
    } else if (title == 'SRI AGENCIES') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SriAgencyPage(),
        ),
      );
    } else if (title == 'PULSES ITEMS') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PulsesItemPage(),
        ),
      );
    } else if (title == 'FOOD ITEMS') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodItemPage(),
        ),
      );
    } else if (title == 'SOAP ITEMS') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SoapItemPage(),
        ),
      );
    } else if (title == 'PASTE ITEMS') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PasteItemPage(),
        ),
      );
    } else if (title == 'TEA') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TeaPage(),
        ),
      );
    } else if (title == 'MANJOLAI TEA') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ManjolaiTeaPage(),
        ),
      );
    } else if (title == 'VEGETABLES') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VegetablesPage(),
        ),
      );
    } else if (title == 'FRUITS') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FruitsPage(),
        ),
      );
    } else if (title == 'ICE ') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Ice(),
        ),
      );
    } else if (title == 'LOCAL FOOD') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocalFoodPage(),
        ),
      );
    }
  }

  Widget _buildFoodItem(FoodItem foodItem, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 20.0),
              child: Container(
                child: Row(
                  children: [
                    Hero(
                      tag: foodItem.imgPath,
                      child: Image(
                        image: NetworkImage(foodItem.imgPath),
                        fit: BoxFit.cover,
                        height: 75.0,
                        width: 75.0,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          foodItem.foodName,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          foodItem.price,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        // Handle favorite icon tap
                        // Toggle the favorite status or perform any other action
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Icon(
                          // //  Icons.favorite_border,
                          //   // color: Colors.red,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 45, 135, 209),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _controller.value,
            child: Transform.translate(
              offset: Offset(0.0, 50.0 * (1.0 - _controller.value)),
              child: child,
            ),
          );
        },
        child: Row(
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
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: 10.0),
                    child: Responsive.isDesktop(context)
                        ? null
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => MultiProvider(
                                        providers: [
                                          ChangeNotifierProvider(
                                            create: (context) =>
                                                MenuAppController(),
                                          ),
                                        ],
                                        child: MainScreen(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                  ),
                  SizedBox(height: 25.0),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Total',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Categories',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(75.0)),
                      ),
                      child: ListView.builder(
                        itemCount: itemTitles.length,
                        itemBuilder: (context, index) {
                          String title = itemTitles[index];
                          int amount = categoryData[index];

                          return _buildFoodItem(
                            FoodItem(
                              imgPath: categoryImages[title]!,
                              foodName: title,
                              price: 'Total Quantity: $amount',
                            ),
                            () {
                              navigateToDetailPage(title);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

Map<String, String> categoryImages = {
  'TOYS':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7CI3nqSjbKVtjezLi4iy3mvdgEPCPwHtwkA&usqp=CAU',
  'GIFT':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDTB5ybEUEu4yJEdpokZpc4lhjTizqwlMpCw&usqp=CAU',
  'STATIONARY ITEMS':
      'https://media.gettyimages.com/id/802352810/photo/top-view-of-a-large-group-of-school-or-office-supplies-on-wooden-table.jpg?s=612x612&w=gi&k=20&c=ADCobOWMlIJalCHffUF_fERuo5AZ-EeDW-lwDw-grX8=',
  'STATIONARY ITEMS 2':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwDjT7n5hvXVSdQlzoweP5NJdRQhw_YPOAqg&usqp=CAU',
  'PLASTIC ITEMS':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyi-eSRN7suQNZSAWMQUc8AFD156haqY8lTg&usqp=CAU',
  'ROYAL STATIONARY':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgXlDP0-1ElBje4JX8fEUfJFKoArI-b9YKGw&usqp=CAU',
  'ROYAL STATIONARY2':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZupyC8ayDLEHziTL8eHb3N0e9qFXAgXLRSA&usqp=CAU',
  'MASALAITEMS':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDVG6C8c8uEowqU2u4qe3SrGmRAJ_9-L1BmA&usqp=CAU',
  'SRI KUMARAN AGENCIES':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3tt6ZxPqBlOEjVCGO3R04WK1j63rhxQmeHQ&usqp=CAU',
  'SRI AGENCIES':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRopuojyEfGsi9H7HQAxktmiMTMUG-Nqq7t2A&usqp=CAU',
  'PULSES ITEMS':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUnhH4KpJM9Mvhs38vYqhruGiB76cxIA8d2Q&usqp=CAU',
  'FOOD ITEMS':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSicywS9T9mi7f_6gKsNnhxNSf3mbhL7flZgw&usqp=CAU',
  'SOAP ITEMS':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTr9oYvsi9_peeAYM4hOfpJhsK86u3_Od8zVP74pcP_l65zJ6zMLaPV1gmzje1dAsCYR0&usqp=CAU',
  'PASTE ITEMS':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOEklFEZ6LXGQqI8Dh3dToynDBGoiSXFjHlg&usqp=CAU',
  'TEA':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdE4m2Yl620UausGXqOvkAXFmpzxVTKgfZcg&usqp=CAU',
  'MANJOLAI TEA':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBUMXVcudrmEGNYfnI5VnLm3KMdtmYn-Rukw&usqp=CAU',
  'VEGETABLES':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpyRUHEA6EaCoQ6ogqTZQvNxnx8qcU36dDw&usqp=CAU',
  'FRUITS':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzxXJzXhROAO1nVLIoJjkU_sNPhKHAzSzcTg&usqp=CAU',
  'ICE ':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThgA47GHL35jZlaar8KhowAFHlzGWNQ2CDrg&usqp=CAU',
  'LOCAL FOOD':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBp4pdrqb8FrrHHYVU0g8DYCkXoy0IcYE5ow&usqp=CAU',
};
