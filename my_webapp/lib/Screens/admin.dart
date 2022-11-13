import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_webapp/Screens/components/appbar.dart';

import 'adminWidget/adminpanelwidget.dart';

class AdminPanel extends StatefulWidget {
  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/turuncu.png"),
            fit: BoxFit.cover,
          ),
        ),
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(flex: 5, child: CustomAppBar()),
            SizedBox(height: 25),
            Flexible(flex: 23, child: AdminPanelWidget())

            // it will cover 2/3 of free spaces
          ],
        ),
      ),
    );
  }
}
