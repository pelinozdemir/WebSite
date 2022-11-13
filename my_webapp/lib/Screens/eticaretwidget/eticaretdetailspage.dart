import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_webapp/Screens/components/appbar.dart';
import 'package:my_webapp/Screens/eticaretwidget/eticaretbody.dart';
import 'package:my_webapp/http.dart';
import 'dart:convert';

class E_TicaretDetails extends StatefulWidget {
  String? baslik;
  String? id;
  String? img;

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
  Widget appbar;
  E_TicaretDetails(
      {required this.baslik,
      required this.id,
      required this.img,
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
      required this.appbar});

  State<E_TicaretDetails> createState() => _E_TicaretDetailsState(
      appbar: appbar,
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
      img: img,
      diskboyut: diskboyut);
}

class _E_TicaretDetailsState extends State<E_TicaretDetails> {
  Widget appbar;
  String? baslik;
  String? id;
  String? img;
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
  _E_TicaretDetailsState(
      {required this.baslik,
      required this.id,
      required this.marka,
      required this.model,
      required this.site,
      required this.img,
      required this.fiyat,
      required this.url,
      required this.islemci,
      required this.isletimsistem,
      required this.ekranboyut,
      required this.diskboyut,
      required this.ram,
      required this.appbar});

  @override
  Widget build(BuildContext context) {
    //Map<dynamic, dynamic>? _productsStream = sel;
    //  print(_productsStream);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/turuncu.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Flexible(flex: 5, child: appbar),
            SizedBox(height: 25),
            Flexible(
                flex: 23,
                child: Container(
                  padding: EdgeInsets.only(left: 60, right: 60),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 0,
                          left: 72,
                          child: Text(
                            baslik.toString().toUpperCase(),
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          )),
                      Positioned(
                        top: 40,
                        left: 70,
                        right: 70,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: Colors.transparent)),
                          child: Row(
                            children: [
                              Positioned(
                                  top: 40,
                                  left: 60,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    height: MediaQuery.of(context).size.height /
                                        1.5,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                            color: Colors.transparent)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        imageUrl: img!,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            new Icon(Icons.error),
                                      ),
                                    ),
                                  )),
                              Positioned(
                                  top: 40,
                                  right: 100,
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    margin: EdgeInsets.all(0),
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height: MediaQuery.of(context).size.height /
                                        1.5,
                                    color: Colors.transparent,
                                    child: ListView(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            "Fiyat:",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 61, 60, 60),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            fiyat.toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            "Marka:",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 61, 60, 60),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            marka.toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            "Model:",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 61, 60, 60),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            model.toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            "İşlemci:",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 61, 60, 60),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            islemci.toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            "İşletim Sistemi:",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 61, 60, 60),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            isletimsistem.toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            "Ekran Boyutu:",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 61, 60, 60),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            ekranboyut.toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            "Disk Boyutu:",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 61, 60, 60),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            diskboyut.toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            "RAM:",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 61, 60, 60),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            ram.toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
  /* child: Scaffold(
          backgroundColor: Colors.amber,
          body: Text(
            liste!.map((e) => e['Model']).elementAt(2).toString(),
            //liste![index]['model'].toString(),
            style: Theme.of(context).textTheme.headline5,
          ) /* GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 4,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(liste!.length, (index) {
            return Center(
              child: Text(
                liste!.map((e) => e['Model']).elementAt(index).toString(),
                //liste![index]['model'].toString(),
                style: Theme.of(context).textTheme.headline5,
              ),
            );
          }),
        ),*/
          ),
    );

    /* Container(
        height: size.height,
        color: Colors.amber,
        // it will take full width
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomAppBar(),
            Spacer(),
            EticaretBody(),
            Spacer(
              flex: 2,
            ),
            // it will cover 2/3 of free spaces
          ],
        ),
      ),
    );*/

    /*return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'HEY',
            ),
            Text(
              '$sel',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );*/
  }
}

class ProductItemView extends StatefulWidget {
  ProductItemModel? product;
  ProductItemView({this.product});
  @override
  State<ProductItemView> createState() => _ProductItemViewState(product: null);
}

class _ProductItemViewState extends State<ProductItemView> {
  ProductItemModel? product;
  _ProductItemViewState({required this.product});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }*/

}
