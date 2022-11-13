import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_webapp/Screens/components/appbar.dart';
import 'package:my_webapp/Screens/eticaretwidget/eticaretdetailspage.dart';
import 'package:my_webapp/Screens/tumurun.dart';
import 'dart:html' as html;
import '../../http.dart';
import 'dart:js' as js;

class TumUrunContainer extends StatefulWidget {
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
  String? img;
  String? ram;
  String? islemci;
  Widget appbar;
  TumUrunContainer(
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
  @override
  State<TumUrunContainer> createState() => _TumUrunContainerState(
      site: site,
      id: id,
      img: img,
      baslik: baslik,
      fiyat: fiyat,
      marka: marka,
      model: model,
      url: url,
      islemci: islemci,
      isletimsistem: isletimsistem,
      ram: ram,
      ekranboyut: ekranboyut,
      diskboyut: diskboyut,
      appbar: appbar);
}

class _TumUrunContainerState extends State<TumUrunContainer> {
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
  String? img;
  String? islemci;
  Widget appbar;
  _TumUrunContainerState(
      {required this.baslik,
      required this.id,
      required this.marka,
      required this.model,
      required this.site,
      required this.fiyat,
      required this.url,
      required this.img,
      required this.islemci,
      required this.isletimsistem,
      required this.ekranboyut,
      required this.diskboyut,
      required this.ram,
      required this.appbar});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (url == 'Eticaret') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => E_TicaretDetails(
                  baslik: baslik,
                  id: id,
                  img: img,
                  marka: marka,
                  model: model,
                  site: site,
                  fiyat: fiyat,
                  url: url,
                  islemci: islemci,
                  isletimsistem: isletimsistem,
                  ekranboyut: ekranboyut,
                  diskboyut: diskboyut,
                  ram: ram,
                  appbar: appbar),
            ),
            (route) => false,
          );
        } else {
          js.context.callMethod('open', [url!]);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.orange, width: 1)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: img!,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
                height: MediaQuery.of(context).size.height / 2,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 234, 223, 223).withOpacity(0.1)),
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 160),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: Colors.grey.withOpacity(0.3)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //  color: Colors.red,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                color: Colors.transparent),
                            child: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(fontSize: 10.0),
                                text: TextSpan(
                                  text: marka,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration:
                                BoxDecoration(color: Colors.transparent),
                            child: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(fontSize: 10.0),
                                text: TextSpan(
                                  text: baslik,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )

                                //style: TextStyle(fontSize: 50),
                                ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration:
                                BoxDecoration(color: Colors.transparent),
                            child: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(fontSize: 10.0),
                                text: TextSpan(
                                  text: fiyat,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration:
                                BoxDecoration(color: Colors.transparent),
                            child: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(fontSize: 10.0),
                                text: TextSpan(
                                  text: site,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                        ]),
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
