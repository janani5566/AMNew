import 'package:responsive_supermarket/responsive.dart';
import 'package:responsive_supermarket/screens/dashboard/components/Dash_SalesCard.dart';
import 'package:flutter/material.dart';
import 'package:responsive_supermarket/config/header.dart';

import '../../constants.dart';
import 'package:responsive_supermarket/screens/dashboard/components/header.dart';

import 'components/DashbWeekly_SalesCard.dart';
import 'components/monthlyDash_details.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            HeadWidget(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Dash_SalesMain(),
                      SizedBox(height: 10),
                      Header3(),
                      SizedBox(height: defaultPadding),
                      WeeklySalesCard(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) Monthly_dash(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Column(
                        children: [
                          Header4(),
                          SizedBox(height: defaultPadding),
                          Monthly_dash(),
                        ],
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
