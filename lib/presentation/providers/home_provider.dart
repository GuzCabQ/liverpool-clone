import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liverpool/domain/entities/entities.dart';
import 'package:liverpool/presentation/providers/product_repository_provider.dart';
import 'package:liverpool/presentation/screens/screens.dart';

class HomeController extends Equatable {
  final List<Product> products;
  final bool isLoading;
  final Order? order;
  final List<Order> orders = [
    const Order(value: 'Relevancia|0', name: 'Relevancia'),
    const Order(value: 'newArrival|1', name: 'Lo más nuevo'),
    const Order(value: 'sortPrice|0', name: 'Menor precio'),
    const Order(value: 'sortPrice|1', name: 'Mayor precio'),
    const Order(value: 'rating|1', name: 'Calificaciones'),
  ];

  HomeController({required this.products, this.order, this.isLoading = false});

  HomeController copyWith(
      {bool? isLoading, List<Product>? products, Order? order}) {
    return HomeController(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      order: order ?? this.order,
    );
  }

  @override
  List<Object?> get props => [];
}

final homeProvider =
    StateNotifierProvider.autoDispose<HomeNotifier, HomeController>((ref) {
  final fetchProducts = ref.watch(productRepositoryProvider).getProductByName;
  return HomeNotifier(fetchProducts: fetchProducts);
});

typedef ProductsCallback = Future<List<Product>> Function(
    {required String name, String? order, int? page});

class HomeNotifier extends StateNotifier<HomeController> {
  String query = '';
  ProductsCallback fetchProducts;
  HomeNotifier({required this.fetchProducts})
      : super(HomeController(
          products: const [],
        ));

  Future<List<Product>> loadProducts(
      {required String name, String? order, int? page = 0}) async {
    if (name.isNotEmpty) {
      query = name;
    }
    state = state.copyWith(
      isLoading: true,
    );
    final List<Product> products =
        await fetchProducts(name: query, page: page, order: order);
    state = state
        .copyWith(isLoading: false, products: [...state.products, ...products]);
    return state.products;
  }

  setProducts(List<Product> products, String name) {
    query = name;
    state = state.copyWith(products: [...products]);
  }

  handleOrder(Order? order) {
    if (order == null) return;
    state = state.copyWith(order: order, products: []);
    loadProducts(name: query, order: order.value);
  }

  goToProductScreen(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductScreen(product: product),
      ),
    );
  }
}
