import 'package:liverpool/domain/entities/product.dart';

abstract class ProductDatasource {
  Future<List<Product>> getProductByName(
      {required String name, String? order, int? page = 1});
}
