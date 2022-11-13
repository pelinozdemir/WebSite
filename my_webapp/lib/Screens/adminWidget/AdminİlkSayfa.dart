import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_webapp/Screens/adminWidget/adminSidebar.dart';
import 'package:my_webapp/Screens/adminWidget/admincustomappbar.dart';
import 'package:my_webapp/Screens/adminWidget/productUpdate.dart';
import 'package:my_webapp/Screens/components/appbar.dart';

class AdminFirstPage extends StatefulWidget {
  @override
  State<AdminFirstPage> createState() => _AdminFirstPageState();
}

class _AdminFirstPageState extends State<AdminFirstPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        // it will take full width
        width: size.width,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/turuncu.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(flex: 5, child: AdminCustomAppBar()),
            SizedBox(height: 15),
            Flexible(
                flex: 23,
                child: Row(
                  children: [
                    Flexible(flex: 5, child: SideLayout()),
                    Flexible(flex: 20, child: Container())
                  ],
                ))

            // it will cover 2/3 of free spaces
          ],
        ),
      ),
    );
  }
}
