import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:liverpool/domain/datasource/product_datasource.dart';
import 'package:liverpool/domain/entities/product.dart';
import 'package:liverpool/infrastructure/mappers/product_mapper.dart';
import 'package:liverpool/infrastructure/models/product_response.dart';

class ProductDatasourceIMPL implements ProductDatasource {
  final _dio = Dio();
  final String _baseUrl =
      'https://shopappst.liverpool.com.mx/appclienteservices/services/v6/plp/sf';
  @override
  Future<List<Product>> getProductByName(
      {required String name, String? order, int? page = 1}) async {
    List<Product> products = [];
    try {
      final response = await _dio.get(_baseUrl, queryParameters: {
        'page-number': page,
        'search-string': name,
        'sort-option': order,
        'force-plp': 'false',
        'number-of-items-per-page': 40,
        'cleanProductName': 'false',
      });
      if (response.statusCode == 200) {
        final data = ProductReponse.fromJson(response.data);
        for (var record in data.plpResults.records) {
          products.add(ProductMapper.toProductEntity(record));
        }
      }
    } catch (e, s) {
      debugPrint('Error: $e, Stack: $s');
      throw Exception(e.toString());
    }
    return products;
  }
}
