import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_webapp/List/Modellist.dart';
import 'package:my_webapp/Screens/components/appbar.dart';
import 'package:my_webapp/Screens/components/filterbar.dart';
import 'package:my_webapp/Screens/eticaretwidget/eticaretbody.dart';
import 'package:my_webapp/http.dart';
import 'dart:convert';

class E_Ticaret extends StatefulWidget {
  @override
  List<dynamic> sel = [];
  List<dynamic>? liste = [];
  Widget appbar;
  String? field;
  String? value;
  String? search;
  E_Ticaret(
      {required this.appbar,
      required this.field,
      required this.value,
      required this.search});
  State<E_Ticaret> createState() => _E_TicaretState(
      sel: sel,
      liste: liste,
      appbar: appbar,
      field: field,
      value: value,
      search: search);
}

class _E_TicaretState extends State<E_Ticaret> {
  int _counter = 0;
  List<dynamic> sel;
  List<dynamic>? liste;
  Widget appbar;
  String? field;
  String? value;
  String? search;
  static const Icon compass = Icon(IconData(0xf8ca));
  int selectedIndex = -1;
  int selectedSideBarCategory = -1;
  String selectedSubcategory = '';
  bool isExtraFeatures = false;
  int currentIndex = 0;
  _E_TicaretState(
      {required this.sel,
      this.liste,
      required this.appbar,
      required this.field,
      required this.value,
      required this.search});
  void initState() {
    // getString(field!, value!);
  }

  Future getString(String f, String v) async {
    await Api().getDisk();
    await Api().getEkran();
    await Api().getRam();
    await Api().getMarka();

    await Api().getSistem();
    sel = await Api().getEticaretList(field!, value!, search!);
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(children: [
                          filterSidebarWidget(sideBarCategoryList),
                          Flexible(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => E_Ticaret(
                                                appbar: this.appbar,
                                                field: "none",
                                                value: "none",
                                                search: "none"),
                                          ));
                                    },
                                    child: Text(
                                      "Filtreleri Kaldır",
                                    )),
                              )),
                        ]),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      flex: 20,
                      child: FutureBuilder(
                          future: getString(field!, value!),
                          builder: (context, snapshot) {
                            return GridView.count(
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                              padding: EdgeInsets.only(left: 40, right: 40),
                              crossAxisCount: 4,
                              children: List.generate(
                                liste!.length,
                                (index) => EticaretContainer(
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
                                  img: liste!
                                      .map((e) => e['Img'])
                                      .elementAt(index)
                                      .toString(),
                                  appbar: appbar,
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded filterSidebarWidget(
      List<Map<dynamic, dynamic>> sideBarCategoryList) {
    return Expanded(
      flex: 4,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 500,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: List.generate(
                  sideBarCategoryList.length,
                  (index) => CategorySideBarRow(
                    title: sideBarCategoryList[index]['title'],
                    caption: sideBarCategoryList[index]['subtitle'],
                    subCategory: sideBarCategoryList[index]['sub_category'],
                    isSelected: selectedSideBarCategory == index,
                    index: index,
                    selectedIndex: selectedSideBarCategory,
                    selectedSubcategory: selectedSubcategory,
                    subCategoryOntap: (String value) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        selectedSubcategory = value;
                        setState(() {
                          print(value);
                          print(sideBarCategoryList[selectedSideBarCategory]
                              ["title"]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => E_Ticaret(
                                  appbar: this.appbar,
                                  field: sideBarCategoryList[
                                      selectedSideBarCategory]["title"],
                                  value: value.toString(),
                                  search: "none",
                                ),
                              ));
                        });
                      });
                    },
                    onTap: () {
                      selectedSideBarCategory = index;
                      setState(() {
                        value = "none";
                        field = "none";
                        search = "none";
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Padding categoryWidget(Size size, List<Map<String, dynamic>> categoryList) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: SizedBox(
        height: 56,
        //width: size.width - size.width * 0.05,
        child: SingleChildScrollView(
          child: ListView.builder(
            itemCount: categoryList.length,
            scrollDirection: Axis.horizontal,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  selectedIndex = index;
                  setState(() {});
                },
                child: Container(
                  //  width: 144,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? const Color(0xFFEBF2FF)
                        : Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        categoryList[index]['title'],
                        style: const TextStyle(
                          color: Color(0xFF2979FF),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
