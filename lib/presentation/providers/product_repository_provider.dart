import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liverpool/infrastructure/datasource/product_datasource_impl.dart';
import 'package:liverpool/infrastructure/repositories/product_repository_impl.dart';

final productRepositoryProvider = Provider((ref) {
  return ProdcutRespositoryIMPL(ProductDatasourceIMPL());
});
