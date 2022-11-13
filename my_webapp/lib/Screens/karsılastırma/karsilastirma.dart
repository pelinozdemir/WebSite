import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_webapp/List/Modellist.dart';
import 'package:my_webapp/Screens/components/appbar.dart';
import 'package:my_webapp/Screens/eticaretwidget/eticaretbody.dart';
import 'package:my_webapp/Screens/kars%C4%B1last%C4%B1rma/kars%C4%B1last%C4%B1rmabody.dart';

import 'package:my_webapp/Screens/tumurunler.dart/tumurunlerbody.dart';
import 'package:my_webapp/http.dart';
import 'dart:convert';
import 'dart:js' as js;

import '../../Models/product.dart';

class KarsilastirmaPage extends StatefulWidget {
  Widget appbar;
  KarsilastirmaPage({required this.appbar});
  @override
  _KarsilastirmaState createState() => _KarsilastirmaState(appbar: appbar);
}

class _KarsilastirmaState extends State<KarsilastirmaPage> {
  var _streamController = StreamController<List<ProductCompare>>();
  var _scrollController = ScrollController();
  /* List<Product> albumList = [];
  List<ProductCompare> productList = [];*/
  Widget appbar;
  _KarsilastirmaState({required this.appbar});

  // Succeeding pages should display 3 more items from the List
  loadMoreproduct(bool increment) {
    setState(() {
      if (!increment)
        _listCursorEnd = 3;
      else
        _listCursorEnd += 3;
    });
  }

  // Call to fetch images
  loadproduct(bool refresh) {
    _streamController.add(productList);
    if (refresh) loadMoreproduct(!refresh); // refresh whole List
  }

  @override
  void initState() {
    super.initState();
    loadproduct(false);
    _scrollController.addListener(
      () {
        if (_scrollController.position.atEdge) {
          if (_scrollController.position.pixels == 0)
            print('List scroll at top');
          else {
            print('List scroll at bottom');
            loadMoreproduct(true);
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  var _listCursorEnd = 21;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _streamController.stream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductCompare>> snapshot) {
        if (snapshot.hasData) {
          // This ensures that the cursor won't exceed List<Album> length
          if (_listCursorEnd > snapshot.data!.length)
            _listCursorEnd = snapshot.data!.length;
          debugPrint(
              'Stream snapshot contains ${snapshot.data!.length} item/s');
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/turuncu.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(children: [
                Flexible(flex: 4, child: appbar),
                SizedBox(height: 10),
                Flexible(
                  flex: 20,
                  child: Container(
                    padding: EdgeInsets.only(left: 95, right: 95),
                    child: RefreshIndicator(
                      onRefresh: () async => loadproduct(true),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          controller: _scrollController,
                          primary: false,
                          padding: const EdgeInsets.all(20),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            //Text(snapshot.data![index].n11.baslik)
                            return Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                  height: 400,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(
                                          color: Colors.transparent)),
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Flexible(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              /* border: Border.all(
                                                    color: Colors.blueAccent)*/
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                imageUrl: snapshot
                                                    .data![index].n11.img,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.fitWidth,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2,
                                                placeholder: (context, url) =>
                                                    new CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        new Icon(Icons.error),
                                              ),
                                            ),
                                          )),
                                      Flexible(
                                          flex: 3,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              /* border: Border.all(
                                                    color: Colors.blueAccent)*/
                                            ),
                                            child: Column(
                                              children: [
                                                Flexible(
                                                    flex: 2,
                                                    child: Container(
                                                      height: 100,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        /*border: Border.all(
                                                              color: Colors
                                                                  .blueAccent)*/
                                                      ),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          snapshot.data![index]
                                                              .n11.baslik,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      255,
                                                                      115,
                                                                      0)),
                                                        ),
                                                      ),
                                                    )),
                                                Flexible(
                                                    flex: 6,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        /*border: Border.all(
                                                              color: Colors
                                                                  .blueAccent)*/
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                              child: Container(
                                                            child: Column(
                                                              children: [
                                                                ListTile(
                                                                  title: Text(
                                                                      "Model:"),
                                                                  subtitle: Text(
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .n11
                                                                          .model),
                                                                ),
                                                                ListTile(
                                                                  title: Text(
                                                                      "Fiyat:"),
                                                                  subtitle: Text(
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .n11
                                                                          .fiyat),
                                                                ),
                                                                ListTile(
                                                                  title: Text(
                                                                      "Site:"),
                                                                  subtitle: Text(
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .n11
                                                                          .site),
                                                                ),
                                                                SizedBox(
                                                                  height: 30,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      ElevatedButton(
                                                                          style:
                                                                              ButtonStyle(
                                                                            backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                                                                                202,
                                                                                191,
                                                                                236,
                                                                                243)),
                                                                            shape:
                                                                                MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10.0), // radius you want
                                                                              side: BorderSide(
                                                                                color: Colors.transparent, //color
                                                                              ),
                                                                            )),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            js.context.callMethod('open', [
                                                                              snapshot.data![index].n11.url
                                                                            ]);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'N11',
                                                                            style: TextStyle(
                                                                                fontSize: 22,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.orange),
                                                                          )),
                                                                )
                                                              ],
                                                            ),
                                                          )),
                                                          Container(
                                                              height: 250,
                                                              child: VerticalDivider(
                                                                  color: Colors
                                                                      .black)),
                                                          Expanded(
                                                              child: Container(
                                                            child: Column(
                                                              children: [
                                                                ListTile(
                                                                  title: Text(
                                                                      "Model:"),
                                                                  subtitle: Text(snapshot
                                                                      .data![
                                                                          index]
                                                                      .trendyol
                                                                      .model),
                                                                ),
                                                                ListTile(
                                                                  title: Text(
                                                                      "Fiyat:"),
                                                                  subtitle: Text(snapshot
                                                                      .data![
                                                                          index]
                                                                      .trendyol
                                                                      .fiyat),
                                                                ),
                                                                ListTile(
                                                                  title: Text(
                                                                      "Site:"),
                                                                  subtitle: Text(snapshot
                                                                      .data![
                                                                          index]
                                                                      .trendyol
                                                                      .site),
                                                                ),
                                                                SizedBox(
                                                                  height: 30,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      ElevatedButton(
                                                                          style:
                                                                              ButtonStyle(
                                                                            backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                                                                                202,
                                                                                191,
                                                                                236,
                                                                                243)),
                                                                            shape:
                                                                                MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10.0), // radius you want
                                                                              side: BorderSide(
                                                                                color: Colors.transparent, //color
                                                                              ),
                                                                            )),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            if (snapshot.data![index].trendyol.url !=
                                                                                "")
                                                                              js.context.callMethod('open', [
                                                                                snapshot.data![index].trendyol.url
                                                                              ]);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Trendyol',
                                                                            style: TextStyle(
                                                                                fontSize: 22,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.orange),
                                                                          )),
                                                                )
                                                              ],
                                                            ),
                                                          )),
                                                          Container(
                                                              height: 250,
                                                              child: VerticalDivider(
                                                                  color: Colors
                                                                      .black)),
                                                          Expanded(
                                                              child: Container(
                                                            child: Column(
                                                              children: [
                                                                ListTile(
                                                                  title: Text(
                                                                      "Model:"),
                                                                  subtitle: Text(snapshot
                                                                      .data![
                                                                          index]
                                                                      .hepsiburada
                                                                      .model),
                                                                ),
                                                                ListTile(
                                                                  title: Text(
                                                                      "Fiyat:"),
                                                                  subtitle: Text(snapshot
                                                                      .data![
                                                                          index]
                                                                      .hepsiburada
                                                                      .fiyat),
                                                                ),
                                                                ListTile(
                                                                  title: Text(
                                                                      "Site:"),
                                                                  subtitle: Text(snapshot
                                                                      .data![
                                                                          index]
                                                                      .hepsiburada
                                                                      .site),
                                                                ),
                                                                SizedBox(
                                                                  height: 30,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      ElevatedButton(
                                                                          style:
                                                                              ButtonStyle(
                                                                            backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                                                                                202,
                                                                                191,
                                                                                236,
                                                                                243)),
                                                                            shape:
                                                                                MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10.0), // radius you want
                                                                              side: BorderSide(
                                                                                color: Colors.transparent, //color
                                                                              ),
                                                                            )),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            if (snapshot.data![index].hepsiburada.url !=
                                                                                "")
                                                                              js.context.callMethod('open', [
                                                                                snapshot.data![index].hepsiburada.url
                                                                              ]);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'HepsiBurada',
                                                                            style: TextStyle(
                                                                                fontSize: 22,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.orange),
                                                                          )),
                                                                )
                                                              ],
                                                            ),
                                                          )),
                                                          Container(
                                                              height: 250,
                                                              child: VerticalDivider(
                                                                  color: Colors
                                                                      .black)),
                                                          Expanded(
                                                              child: Container(
                                                            child: Column(
                                                              children: [
                                                                ListTile(
                                                                  title: Text(
                                                                      "Model:"),
                                                                  subtitle: Text(snapshot
                                                                      .data![
                                                                          index]
                                                                      .teknosa
                                                                      .model),
                                                                ),
                                                                ListTile(
                                                                  title: Text(
                                                                      "Fiyat:"),
                                                                  subtitle: Text(snapshot
                                                                      .data![
                                                                          index]
                                                                      .teknosa
                                                                      .fiyat
                                                                      .replaceAll(
                                                                          ' ',
                                                                          '')),
                                                                ),
                                                                ListTile(
                                                                  title: Text(
                                                                      "Site:"),
                                                                  subtitle: Text(snapshot
                                                                      .data![
                                                                          index]
                                                                      .teknosa
                                                                      .site),
                                                                ),
                                                                SizedBox(
                                                                  height: 30,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      ElevatedButton(
                                                                          style:
                                                                              ButtonStyle(
                                                                            backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                                                                                202,
                                                                                191,
                                                                                236,
                                                                                243)),
                                                                            shape:
                                                                                MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10.0), // radius you want
                                                                              side: BorderSide(
                                                                                color: Colors.transparent, //color
                                                                              ),
                                                                            )),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            if (snapshot.data![index].teknosa.url !=
                                                                                "")
                                                                              js.context.callMethod('open', [
                                                                                snapshot.data![index].teknosa.url
                                                                              ]);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Teknosa',
                                                                            style: TextStyle(
                                                                                fontSize: 22,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.orange),
                                                                          )),
                                                                )
                                                              ],
                                                            ),
                                                          )),
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          )),
                                    ],
                                  )
                                  // child: Thumbnail(image: imagePath, size: Size(100, 100)),
                                  ),
                            );
                          }),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }

  Widget buildImage({String? image, double? height, double? width}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.white, width: 2.0),
          image: DecorationImage(
              image: NetworkImage(image.toString()), fit: BoxFit.cover)),
    );
  }
}
