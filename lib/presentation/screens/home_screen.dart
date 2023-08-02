import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liverpool/presentation/delegates/search_movie_delegate.dart';
import 'package:liverpool/presentation/providers/providers.dart';
import 'package:liverpool/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const name = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentPage = 0;
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels + 500 >=
        _scrollController.position.maxScrollExtent) {
      if (!ref.watch(homeProvider).isLoading) {
        currentPage++;
        ref
            .read(homeProvider.notifier)
            .loadProducts(name: '', page: currentPage);
      }
    }
  }

  _searchProduct(BuildContext context) async {
    final searchedMovies = ref.read(searchedProductProvider);
    final searchQuery = ref.read(searchQueryProvider);

    await showSearch<SearchResult>(
            query: searchQuery,
            context: context,
            delegate: SearchProductDelegate(
                initialMovies: searchedMovies,
                searchMovies:
                    ref.read(productRepositoryProvider).getProductByName))
        .then(
      (result) {
        if (result != null) {
          ref
              .read(homeProvider.notifier)
              .setProducts(result.products, result.query);
          if (result.product != null) {
            ref
                .read(homeProvider.notifier)
                .goToProductScreen(context, result.product!);
          }
        }
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final ctrl = ref.watch(homeProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tu búsqueda'),
        actions: [
          IconButton(
            onPressed: () async {
              await _searchProduct(context);
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Filter(
              products: ctrl.products,
              items: ctrl.orders,
              value: ctrl.order,
              onChanged: ref.read(homeProvider.notifier).handleOrder,
            ),
            Expanded(
              child: ProductsList(
                controller: _scrollController,
                products: ctrl.products,
                isLoading: ctrl.isLoading,
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     currentPage++;
      //     ref
      //         .read(homeProvider.notifier)
      //         .loadProducts(name: '', page: currentPage);
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
