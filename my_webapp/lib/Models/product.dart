class Product {
  final String baslik;
  final String model;
  final String fiyat;
  final String site;
  final String img;
  final String url;

  Product(
      {required this.baslik,
      required this.img,
      required this.url,
      required this.model,
      required this.fiyat,
      required this.site});

  factory Product.fromJson(Map<dynamic, dynamic> json) {
    return Product(
      img: json['Img'],
      url: json['url'],
      baslik: json['baslık'],
      model: json['Model'],
      fiyat: json['fiyat'],
      site: json['site'],
    );
  }
}

class ProductCompare {
  final Product n11;
  final Product trendyol;
  final Product hepsiburada;
  final Product teknosa;

  ProductCompare(
      {required this.n11,
      required this.trendyol,
      required this.hepsiburada,
      required this.teknosa});
}
