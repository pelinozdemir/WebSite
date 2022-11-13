import 'package:my_webapp/Models/product.dart';

List<dynamic> Models = [];
List<Product> albumList = [];
List<ProductCompare> productList = [];

List<Map<dynamic, dynamic>> sideBarCategoryList = [
  {"title": "Marka", "sub_category": <dynamic>[], "subtitle": ""},
  {
    "title": "İşletim Sistemi",
    "subtitle": "",
    "sub_category": <dynamic>[],
  },
  {
    "title": "Ram",
    "subtitle": "",
    "sub_category": <dynamic>[],
  },
  {
    "title": "Ekran Boyutu",
    "subtitle": "",
    "sub_category": <dynamic>[],
  },
  {
    "title": "Disk Boyutu",
    "subtitle": "",
    "sub_category": <dynamic>[],
  }
];

Map<dynamic, Map<dynamic, bool>> checkMap = {
  "Model": {},
  "Disk Boyutu": {},
  "Ekran Boyutu": {},
  "Ram": {},
  "İşlemci": {}
};
