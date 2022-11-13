import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_webapp/Screens/adminWidget/adminSidebar.dart';
import 'package:my_webapp/Screens/adminWidget/admincustomappbar.dart';
import 'package:my_webapp/Screens/adminWidget/productUpdate.dart';
import 'package:my_webapp/Screens/components/appbar.dart';

class AdminPage extends StatefulWidget {
  Widget view;
  AdminPage({required this.view});
  @override
  State<AdminPage> createState() => _AdminPageState(view: view);
}

class _AdminPageState extends State<AdminPage> {
  Widget view;
  _AdminPageState({required this.view});
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
            Flexible(flex: 5, child: AdminCustomAppBar()),
            SizedBox(height: 15),
            Flexible(
                flex: 23,
                child: Row(
                  children: [
                    Flexible(flex: 5, child: SideLayout()),
                    Flexible(flex: 20, child: view)
                  ],
                ))

            // it will cover 2/3 of free spaces
          ],
        ),
      ),
    );
  }
}
