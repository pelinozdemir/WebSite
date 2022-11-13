import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_webapp/Screens/eticaretwidget/eticaretdetailspage.dart';
import 'dart:html' as html;
import '../../http.dart';
import 'dart:js' as js;

class KarsilastirmaContainer extends StatefulWidget {
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
  Widget appbar;
  KarsilastirmaContainer(
      {required this.baslik,
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
      required this.appbar});
  @override
  State<KarsilastirmaContainer> createState() => _KarsilastirmaContainerState(
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
      diskboyut: diskboyut,
      appbar: appbar);
}

class _KarsilastirmaContainerState extends State<KarsilastirmaContainer> {
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
  Widget appbar;
  _KarsilastirmaContainerState(
      {required this.baslik,
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
      required this.appbar});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        js.context.callMethod('open', [url!]);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: [
            Text(marka!),
            Text(baslik!),
            Text(model!),
            Text(site!),
            Text(fiyat!),
          ],
        ),
      ),
    );
  }
}
