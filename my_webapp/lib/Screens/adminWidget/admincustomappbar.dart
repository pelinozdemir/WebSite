import 'package:flutter/material.dart';
import 'package:my_webapp/Screens/admin.dart';
import 'package:my_webapp/Screens/adminWidget/Admin%C4%B0lkSayfa.dart';
import 'package:my_webapp/Screens/adminWidget/AdminPage.dart';
import 'package:my_webapp/Screens/e_ticaret.dart';

import 'package:my_webapp/Screens/components/menuitem.dart' as menuitem;
import 'package:my_webapp/Screens/tumurun.dart';

import '../components/appbar.dart';
import '../karsılastırma/karsilastirma.dart';

class AdminCustomAppBar extends StatelessWidget {
  TextEditingController search = TextEditingController();
  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: search,
        autofocus: true,
        decoration: InputDecoration(
          hintText: "Search Data...",
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white30),
        ),
        style: TextStyle(color: Colors.white, fontSize: 16.0),
        onChanged: (value) {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();

    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(46),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -2),
            blurRadius: 30,
            color: Colors.black.withOpacity(0.16),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 5),
          Text(
            "WebSite".toUpperCase(),
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Container(
              width: 400,
              height: 200,
              child: TextField(
                controller: textController,
                onSubmitted: (value) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TumUrun(
                      appbar: CustomAppBar(),
                      field: "none",
                      value: "none",
                      search: textController.text,
                    ),
                  ));
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  fillColor: Colors.black,
                  hoverColor: Colors.black,
                  focusColor: Colors.black,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: "Search",
                ),
              ),
            ),
          ),
          Spacer(),
          menuitem.MenuItem(
            title: "Anasayfa",
            press: () {},
          ),
          menuitem.MenuItem(
            title: "Tüm Ürünler",
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TumUrun(
                  appbar: AdminCustomAppBar(),
                  field: "none",
                  value: "none",
                  search: "none",
                ),
              ));
            },
          ),
          menuitem.MenuItem(
            title: "Karşılaştırma",
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => KarsilastirmaPage(
                  appbar: AdminCustomAppBar(),
                ),
              ));
            },
          ),
          menuitem.MenuItem(
            title: "E-Ticaret",
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => E_Ticaret(
                  appbar: AdminCustomAppBar(),
                  field: "none",
                  value: "none",
                  search: "none",
                ),
              ));
            },
          ),
          InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => (AdminFirstPage())));
              },
              child: Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueGrey.withOpacity(0.3)),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 30,
                      ),
                      Text(
                        'Admin',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ]),
              )),

          /* menuitem.MenuItem(
            title: "Yönetici Girişi",
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AdminPanel(),
              ));
            },
          ),*/
        ],
      ),
    );
  }
}
