import 'package:liverpool/domain/entities/product.dart';
import 'package:liverpool/infrastructure/models/product_response.dart';

class ProductMapper {
  static Product toProductEntity(Record response) {
    return Product(
        name: response.productDisplayName,
        listPrice: response.listPrice,
        promoPrice: response.promoPrice,
        imageUrl: response.smImage ?? Product.defaultProductImage,
        colors: response.variantsColor == null
            ? null
            : response.variantsColor!.map((e) => e.colorHex).toList());
  }
}
