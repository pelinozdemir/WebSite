import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_webapp/Screens/adminWidget/productupdatecontainer.dart';
import 'package:my_webapp/Screens/components/appbar.dart';
import 'package:my_webapp/Screens/eticaretwidget/eticaretbody.dart';
import 'package:my_webapp/http.dart';
import 'dart:convert';

class ProductUpdate extends StatefulWidget {
  @override
  List<dynamic> sel = [];
  List<dynamic>? liste = [];

  State<ProductUpdate> createState() => _ProductUpdateState(
        sel: sel,
        liste: liste,
      );
}

class _ProductUpdateState extends State<ProductUpdate> {
  int _counter = 0;
  List<dynamic> sel;
  List<dynamic>? liste;

  _ProductUpdateState({
    required this.sel,
    this.liste,
  });
  void initState() {}

  Future getString() async {
    sel = await Api().getEticaretList("none", "none", "none");
    //print(sel.length);
    //print(sel);
    for (var element in sel) {
      liste!.add(element);

      //print(element['Model']);
    }
  }

  @override
  Widget build(BuildContext context) {
    //Map<dynamic, dynamic>? _productsStream = sel;
    //  print(_productsStream);
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Flexible(
            flex: 20,
            child: FutureBuilder(
                future: getString(),
                builder: (context, snapshot) {
                  return GridView.count(
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    padding: EdgeInsets.only(left: 20, right: 40),
                    crossAxisCount: 4,
                    children: List.generate(
                      liste!.length,
                      (index) => ProductUpdateContainer(
                        id: (liste!
                            .map((e) => e['_id'])
                            .elementAt(index)
                            .toString()),
                        baslik: (liste!
                            .map((e) => e['baslık'])
                            .elementAt(index)
                            .toString()),
                        marka: liste!
                            .map((e) => e['Marka'])
                            .elementAt(index)
                            .toString(),
                        model: liste!
                            .map((e) => e['Model'])
                            .elementAt(index)
                            .toString(),
                        site: liste!
                            .map((e) => e['site'])
                            .elementAt(index)
                            .toString(),
                        fiyat: liste!
                            .map((e) => e['fiyat'])
                            .elementAt(index)
                            .toString(),
                        url: liste!
                            .map((e) => e['url'])
                            .elementAt(index)
                            .toString(),
                        diskboyut: liste!
                            .map((e) => e['Disk Boyutu'])
                            .elementAt(index)
                            .toString(),
                        ekranboyut: liste!
                            .map((e) => e['Ekran Boyutu'])
                            .elementAt(index)
                            .toString(),
                        isletimsistem: liste!
                            .map((e) => e['İşletim Sistemi'])
                            .elementAt(index)
                            .toString(),
                        islemci: liste!
                            .map((e) => e['İşlemci'])
                            .elementAt(index)
                            .toString(),
                        ram: liste!
                            .map((e) => e['Ram'])
                            .elementAt(index)
                            .toString(),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
