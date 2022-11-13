import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_webapp/Screens/adminWidget/productUpdate.dart';

import '../../http.dart';
import 'AdminPage.dart';

class AddProduct extends StatefulWidget {
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
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
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.transparent, width: 1)),
          padding: EdgeInsets.only(left: 60, right: 60, top: 20),
          margin: EdgeInsets.only(left: 60, right: 60, bottom: 30, top: 30),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: rbaslik,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText: "Ürün Başlık",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: rmarka,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText: "Marka",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: rmodel,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText: "Model",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: rfiyat,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText: "Fiyat",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: rram,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText: "RAM",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: rekran,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText: "Ekran Boyutu",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: rdisk,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText: "Disk Boyutu",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: rislemci,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText: "İşlemci",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: rsistem,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText: "İşletim Sistemi",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: (() {
                        ekle();
                      }),
                      child: Text('EKLE',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }

  void ekle() async {
    try {
      print(rbaslik.text);
      print(rmodel.text);
      await Api().add(rbaslik.text, rmodel.text, rmarka.text, rekran.text,
          rdisk.text, rram.text, rislemci.text, rsistem.text, rfiyat.text);
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
