import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_webapp/List/Modellist.dart';

import 'Models/product.dart';

class Api {
  Future<List> getProductList() async {
    var response =
        await http.get(Uri.parse("http://127.0.0.1:5000/productlist"));
    if (response.statusCode == 200) {
      var j = response.body;
      List liste = json.decode(j);

      return liste;
    } else {
      return ["none"];
    }
  }

  Future<List> getEticaretList(
      String field, String value, String search) async {
    Map<String, String> data = {
      "field": field,
      "value": value,
      "search": search
    };
    var body = json.encode(data);
    var response = await http.post(
        Uri.parse(
          "http://127.0.0.1:5000/eticaret",
        ),
        body: data);
    if (response.statusCode == 200) {
      var j = response.body;
      List liste = json.decode(j);

      return liste;
    } else {
      return ["none"];
    }
  }

  adminlogin(String mail, String sifre) async {
    Map<String, String> data = {"email": mail, "password": sifre};
    var body = json.encode(data);

    var response = await http
        .post(Uri.parse("http://127.0.0.1:5000/admin/login"), body: data);

    if (response.statusCode == 200) {
      var j = response.body;

      String giris = j.toString();

      return giris;
    } else {
      return "none";
    }
  }

  update(
      String _id,
      String baslik,
      String model,
      String marka,
      String ekran,
      String disk,
      String ram,
      String islemci,
      String isletimsistem,
      String fiyat) async {
    Map<String, String> data = {
      "id": _id,
      "baslik": baslik,
      "marka": marka,
      "model": model,
      "islemci": islemci,
      "isletimsistem": isletimsistem,
      "ekran": ekran,
      "disk": disk,
      "ram": ram,
      "fiyat": fiyat,
    };
    var body = json.encode(data);

    var response = await http
        .post(Uri.parse("http://127.0.0.1:5000/eticaret/update"), body: data);

    if (response.statusCode == 200) {
      var j = response.body;

      String giris = j.toString();

      return giris;
    } else {
      return "none";
    }
  }

  add(String baslik, String model, String marka, String ekran, String disk,
      String ram, String islemci, String isletimsistem, String fiyat) async {
    Map<String, String> data = {
      "baslik": baslik,
      "marka": marka,
      "model": model,
      "islemci": islemci,
      "isletimsistem": isletimsistem,
      "ekran": ekran,
      "disk": disk,
      "ram": ram,
      "fiyat": fiyat,
    };
    var body = json.encode(data);

    var response = await http
        .post(Uri.parse("http://127.0.0.1:5000/eticaret/add"), body: data);

    if (response.statusCode == 200) {
      var j = response.body;

      String giris = j.toString();

      return giris;
    } else {
      return "none";
    }
  }

  delete(
    String _id,
  ) async {
    Map<String, String> data = {
      "id": _id,
    };
    var body = json.encode(data);

    var response = await http
        .post(Uri.parse("http://127.0.0.1:5000/eticaret/remove"), body: data);

    if (response.statusCode == 200) {
      var j = response.body;

      String giris = j.toString();

      return giris;
    } else {
      return "none";
    }
  }

  Future<List> filterModelGet() async {
    var response =
        await http.get(Uri.parse("http://127.0.0.1:5000/compare/model"));

    if (response.statusCode == 200) {
      var j = response.body;
      List<dynamic> liste = json.decode(j) as List<dynamic>;
      Models = liste;
      return liste;
    } else {
      return ["none"];
    }
  }

  Future<List> getMarka() async {
    var response =
        await http.get(Uri.parse("http://127.0.0.1:5000/filtre/marka"));

    if (response.statusCode == 200) {
      var j = response.body;
      List<dynamic> liste = json.decode(j) as List<dynamic>;
      sideBarCategoryList[0]["sub_category"] = liste;
      return liste;
    } else {
      return ["none"];
    }
  }

  Future<List> getDisk() async {
    var response =
        await http.get(Uri.parse("http://127.0.0.1:5000/filtre/disk"));

    if (response.statusCode == 200) {
      var j = response.body;
      List<dynamic> liste = json.decode(j) as List<dynamic>;
      sideBarCategoryList[4]["sub_category"] = liste;
      return liste;
    } else {
      return ["none"];
    }
  }

  Future<List> getEkran() async {
    var response =
        await http.get(Uri.parse("http://127.0.0.1:5000/filtre/ekran"));

    if (response.statusCode == 200) {
      var j = response.body;
      List<dynamic> liste = json.decode(j) as List<dynamic>;
      sideBarCategoryList[3]["sub_category"] = liste;
      return liste;
    } else {
      return ["none"];
    }
  }

  Future<List> getSistem() async {
    var response =
        await http.get(Uri.parse("http://127.0.0.1:5000/filtre/sistem"));

    if (response.statusCode == 200) {
      var j = response.body;
      List<dynamic> liste = json.decode(j) as List<dynamic>;
      sideBarCategoryList[1]["sub_category"] = liste;
      return liste;
    } else {
      return ["none"];
    }
  }

  Future<List> getRam() async {
    var response =
        await http.get(Uri.parse("http://127.0.0.1:5000/filtre/ram"));

    if (response.statusCode == 200) {
      var j = response.body;
      List<dynamic> liste = json.decode(j) as List<dynamic>;
      sideBarCategoryList[2]["sub_category"] = liste;
      return liste;
    } else {
      return ["none"];
    }
  }

  Future<List> getFilterProduct(
      String field, String value, String search) async {
    Map<String, String> data = {
      "field": field,
      "value": value,
      "search": search
    };
    var body = json.encode(data);
    var response = await http
        .post(Uri.parse("http://127.0.0.1:5000/user/filter"), body: data);

    if (response.statusCode == 200) {
      var j = response.body;
      List liste = json.decode(j);

      return liste;
    } else {
      return ["none"];
    }
  }

  Future<List<ProductCompare>> fetchData() async {
    int i = 0, son_index = 0;
    Product? n11, trendyol, hepsiburada, teknosa;
    bool n11_bool = false;
    bool trenyol_bool = false;
    bool hb_bool = false;
    bool teknosa_bool = false;
    await Api().filterModelGet();
    print(Models);
    for (var model in Models) {
      Map<String, String> data = {
        "model": model.toString(),
      };
      var body = json.encode(data);

      final response = await http
          .post(Uri.parse('http://127.0.0.1:5000/compare'), body: data);

      if (response.statusCode == 200) {
        Iterable iterableProducts = json.decode(response.body);

        List<Map<String, dynamic>>.from(iterableProducts)
            .map((Map<dynamic, dynamic> model) {
          albumList
              .add(Product.fromJson(model)); //albumliste her dokumanı ekleriz

          i++;
        }).toList();

        for (son_index; son_index < albumList.length; son_index++) {
          if (albumList[son_index].site == 'N11') {
            n11 = albumList[son_index];

            n11_bool = true;
          }
          if (albumList[son_index].site == 'Trendyol') {
            trendyol = albumList[son_index];

            trenyol_bool = true;
          }
          if (albumList[son_index].site == 'Hepsiburada') {
            hepsiburada = albumList[son_index];

            hb_bool = true;
          }
          if (albumList[son_index].site == 'Teknosa') {
            teknosa = albumList[son_index];

            teknosa_bool = true;
          }
        }

        if (n11_bool == false) {
          n11 = Product(
              baslik: "",
              model: "",
              fiyat: "Ürün Stokta Yok",
              site: "N11",
              img: "",
              url: "");
        }
        if (trenyol_bool == false) {
          trendyol = Product(
              baslik: "",
              model: "",
              fiyat: "Ürün Stokta Yok",
              site: "Trendyol",
              img: "",
              url: "");
        }
        if (hb_bool == false) {
          hepsiburada = Product(
              baslik: "",
              model: "",
              fiyat: "Ürün Stokta Yok",
              site: "Hepsiburada",
              img: "",
              url: "");
        }
        if (teknosa_bool == false) {
          teknosa = Product(
              baslik: "",
              model: "",
              fiyat: "Ürün Stokta Yok",
              site: "Teknosa",
              img: "",
              url: "");
        }
        n11_bool = false;
        trenyol_bool = false;
        hb_bool = false;
        teknosa_bool = false;
        productList.add(ProductCompare(
            n11: n11!,
            trendyol: trendyol!,
            hepsiburada: hepsiburada!,
            teknosa: teknosa!));
      }

      son_index = i;
    }

    return productList;
  }
}
