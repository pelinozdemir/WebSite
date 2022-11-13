import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_webapp/Screens/adminWidget/AdminPage.dart';
import 'package:my_webapp/Screens/adminWidget/productUpdate.dart';
import 'dart:html' as html;
import '../../http.dart';
import 'dart:js' as js;

class ProductUpdateContainer extends StatefulWidget {
  String? baslik;
  String? id;
  String? marka;
  String? model;
  String? site;
  String? fiyat;
  String? url;
  String? isletimsistem;
  String? diskboyut;
  String? ekranboyut;
  String? ram;
  String? islemci;
  ProductUpdateContainer({
    required this.baslik,
    required this.id,
    required this.marka,
    required this.model,
    required this.site,
    required this.fiyat,
    required this.url,
    required this.islemci,
    required this.isletimsistem,
    required this.ekranboyut,
    required this.diskboyut,
    required this.ram,
  });
  @override
  State<ProductUpdateContainer> createState() => _ProductUpdateContainerState(
      site: site,
      id: id,
      baslik: baslik,
      fiyat: fiyat,
      marka: marka,
      model: model,
      url: url,
      islemci: islemci,
      isletimsistem: isletimsistem,
      ram: ram,
      ekranboyut: ekranboyut,
      diskboyut: diskboyut);
}

class _ProductUpdateContainerState extends State<ProductUpdateContainer> {
  String? baslik;
  String? id;
  String? marka;
  String? model;
  String? site;
  String? url;
  String? fiyat;
  String? isletimsistem;
  String? diskboyut;
  String? ekranboyut;
  String? ram;
  String? islemci;
  _ProductUpdateContainerState({
    required this.baslik,
    required this.id,
    required this.marka,
    required this.model,
    required this.site,
    required this.fiyat,
    required this.url,
    required this.islemci,
    required this.isletimsistem,
    required this.ekranboyut,
    required this.diskboyut,
    required this.ram,
  });
  TextEditingController rbaslik = TextEditingController();
  TextEditingController rmodel = TextEditingController();
  TextEditingController rram = TextEditingController();
  TextEditingController rmarka = TextEditingController();
  TextEditingController rfiyat = TextEditingController();
  TextEditingController rekran = TextEditingController();
  TextEditingController rdisk = TextEditingController();
  TextEditingController rislemci = TextEditingController();
  TextEditingController rsistem = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        height: 200,
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
            ]),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: rbaslik,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: baslik.toString(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: rmarka,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: marka.toString(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: rmodel,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: model.toString(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: rfiyat,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: fiyat.toString(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: rram,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: ram.toString(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: rekran,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: ekranboyut.toString(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: rdisk,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: diskboyut.toString(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: rislemci,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: islemci.toString(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: rsistem,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: isletimsistem.toString(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(202, 191, 236, 243)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // radius you want
                            side: BorderSide(
                              color: Colors.transparent, //color
                            ),
                          )),
                        ),
                        onPressed: (() {
                          guncelle();
                        }),
                        child: Text('Guncelle',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black87)),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(202, 191, 236, 243)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // radius you want
                            side: BorderSide(
                              color: Colors.transparent, //color
                            ),
                          )),
                        ),
                        onPressed: (() {
                          sil();
                        }),
                        child: Text('Sil',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black87)),
                      ),
                    ]),
              ],
            )
          ],
        ));
  }

  void guncelle() async {
    try {
      print("object guncelle");
      print(rbaslik.text);
      print(rmodel.text);
      await Api().update(
          id!,
          rbaslik.text,
          rmodel.text,
          rmarka.text,
          rekran.text,
          rdisk.text,
          rram.text,
          rislemci.text,
          rsistem.text,
          rfiyat.text);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => AdminPage(view: ProductUpdate()),
          ),
          (route) => true);
    } catch (e) {
      print(e);
    }
  }

  void sil() async {
    try {
      await Api().delete(
        id!,
      );
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => AdminPage(view: ProductUpdate()),
          ),
          (route) => true);
    } catch (e) {
      print(e);
    }
  }
}
