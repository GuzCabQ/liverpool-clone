import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liverpool/domain/entities/product.dart';
import 'package:liverpool/presentation/providers/product_repository_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedProductProvider =
    StateNotifierProvider<SearchProductsNotifier, List<Product>>((ref) {
  final productRepository = ref.read(productRepositoryProvider);
  return SearchProductsNotifier(
      searchMovies: productRepository.getProductByName, ref: ref);
});

typedef SearchMoviesCallBack = Future<List<Product>> Function(
    {required String name, String? order, int? page});

class SearchProductsNotifier extends StateNotifier<List<Product>> {
  final Ref ref;
  final SearchMoviesCallBack searchMovies;
  SearchProductsNotifier({
    required this.searchMovies,
    required this.ref,
  }) : super([]);

  Future<List<Product>> searchMoviesByQuery(String query) async {
    final List<Product> products = await searchMovies(name: query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = products;
    return state;
  }
}
