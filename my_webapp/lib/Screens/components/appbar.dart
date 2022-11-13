import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_webapp/Screens/admin.dart';
import 'package:my_webapp/Screens/e_ticaret.dart';

import 'package:my_webapp/Screens/kars%C4%B1last%C4%B1rma/karsilastirma.dart';

import 'package:my_webapp/Screens/tumurun.dart';

import 'menuitem.dart' as menuitem;

class CustomAppBar extends StatefulWidget {
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(17),
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
                title: "AnaSayfa",
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TumUrun(
                      appbar: CustomAppBar(),
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
                      appbar: CustomAppBar(),
                    ),
                  ));
                },
              ),
              menuitem.MenuItem(
                title: "E-Ticaret",
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => E_Ticaret(
                      appbar: CustomAppBar(),
                      field: "none",
                      value: "none",
                      search: "none",
                    ),
                  ));
                },
              ),
              menuitem.MenuItem(
                title: "Yönetici Girişi",
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AdminPanel(),
                  ));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
