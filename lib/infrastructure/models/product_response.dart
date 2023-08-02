class ProductReponse {
  PlpResults plpResults;

  ProductReponse({
    required this.plpResults,
  });

  factory ProductReponse.fromJson(Map<String, dynamic> json) => ProductReponse(
        plpResults: PlpResults.fromJson(json["plpResults"]),
      );
}

class PlpResults {
  List<Record> records;

  PlpResults({
    required this.records,
  });

  factory PlpResults.fromJson(Map<String, dynamic> json) => PlpResults(
        records:
            List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
      );
}

class Record {
  String productId;
  String productDisplayName;
  double listPrice;
  double minimumListPrice;
  double maximumListPrice;
  double promoPrice;
  double minimumPromoPrice;
  double maximumPromoPrice;
  bool isHybrid;
  bool isMarketPlace;
  bool isImportationProduct;
  String? brand;
  String category;

  List<String> categoryBreadCrumbs;
  String? smImage;
  String? lgImage;
  String? xlImage;
  List<VariantsColor>? variantsColor;

  Record({
    required this.productId,
    required this.productDisplayName,
    required this.listPrice,
    required this.minimumListPrice,
    required this.maximumListPrice,
    required this.promoPrice,
    required this.minimumPromoPrice,
    required this.maximumPromoPrice,
    required this.isHybrid,
    required this.isMarketPlace,
    required this.isImportationProduct,
    this.brand,
    required this.category,
    required this.categoryBreadCrumbs,
    this.smImage,
    this.lgImage,
    this.xlImage,
    required this.variantsColor,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        productId: json["productId"],
        productDisplayName: json["productDisplayName"],
        listPrice: json["listPrice"],
        minimumListPrice: json["minimumListPrice"],
        maximumListPrice: json["maximumListPrice"],
        promoPrice: json["promoPrice"]?.toDouble(),
        minimumPromoPrice: json["minimumPromoPrice"]?.toDouble(),
        maximumPromoPrice: json["maximumPromoPrice"]?.toDouble(),
        isHybrid: json["isHybrid"],
        isMarketPlace: json["isMarketPlace"],
        isImportationProduct: json["isImportationProduct"],
        brand: json["brand"],
        category: json["category"],
        categoryBreadCrumbs:
            List<String>.from(json["categoryBreadCrumbs"].map((x) => x)),
        smImage: json["smImage"],
        lgImage: json["lgImage"],
        xlImage: json["xlImage"],
        variantsColor: json["variantsColor"] == null
            ? null
            : List<VariantsColor>.from(
                json["variantsColor"].map((x) => VariantsColor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productDisplayName": productDisplayName,
        "listPrice": listPrice,
        "minimumListPrice": minimumListPrice,
        "maximumListPrice": maximumListPrice,
        "promoPrice": promoPrice,
        "minimumPromoPrice": minimumPromoPrice,
        "maximumPromoPrice": maximumPromoPrice,
        "isHybrid": isHybrid,
        "isMarketPlace": isMarketPlace,
        "isImportationProduct": isImportationProduct,
        "brand": brand,
        "category": category,
        "categoryBreadCrumbs":
            List<dynamic>.from(categoryBreadCrumbs.map((x) => x)),
        "smImage": smImage,
        "lgImage": lgImage,
        "xlImage": xlImage,
      };
}

class VariantsColor {
  String colorName;
  String colorHex;
  String colorImageUrl;
  String colorMainUrl;
  String skuId;

  VariantsColor({
    required this.colorName,
    required this.colorHex,
    required this.colorImageUrl,
    required this.colorMainUrl,
    required this.skuId,
  });

  factory VariantsColor.fromJson(Map<String, dynamic> json) => VariantsColor(
        colorName: json["colorName"],
        colorHex: json["colorHex"],
        colorImageUrl: json["colorImageURL"],
        colorMainUrl: json["colorMainURL"],
        skuId: json["skuId"],
      );

  Map<String, dynamic> toJson() => {
        "colorName": colorName,
        "colorHex": colorHex,
        "colorImageURL": colorImageUrl,
        "colorMainURL": colorMainUrl,
        "skuId": skuId,
      };
}
