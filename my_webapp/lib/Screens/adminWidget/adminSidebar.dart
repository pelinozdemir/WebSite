import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_webapp/Screens/adminWidget/AdminPage.dart';
import 'package:my_webapp/Screens/adminWidget/addproduct.dart';
import 'package:my_webapp/Screens/adminWidget/productUpdate.dart';
import 'package:my_webapp/Screens/components/appbar.dart';
import 'package:my_webapp/Screens/tumurun.dart';

class SideLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.transparent),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -2),
              blurRadius: 30,
              color: Colors.black.withOpacity(0.16),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width / 4,
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AdminPage(view: ProductUpdate()),
                ));
              },
              child: ListTile(
                leading: Icon(Icons.update),
                title: Text(
                  "Ürün İşlemleri",
                  style: TextStyle(
                    color: const Color(0xFF19191D),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AdminPage(view: AddProduct()),
                ));
              },
              child: ListTile(
                leading: Icon(Icons.add),
                title: Text(
                  "Ürün Ekle",
                  style: TextStyle(
                    color: const Color(0xFF19191D),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TumUrun(
                          appbar: CustomAppBar(),
                          field: "none",
                          search: "none",
                          value: "none"),
                    ),
                    (route) => false);
              },
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  "Çıkış",
                  style: TextStyle(
                    color: const Color(0xFF19191D),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
