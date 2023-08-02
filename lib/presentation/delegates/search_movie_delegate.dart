import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:liverpool/domain/entities/product.dart';

typedef SearchProductsCallback = Future<List<Product>> Function(
    {required String name, String? order, int? page});

class SearchProductDelegate extends SearchDelegate<SearchResult> {
  final SearchProductsCallback searchMovies;
  List<Product> initialMovies;

  StreamController<List<Product>> debouncedMovies =
      StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchProductDelegate({
    required this.searchMovies,
    required this.initialMovies,
  }) : super(
          searchFieldLabel: 'Buscar en Liverpool...',
          // textInputAction: TextInputAction.done
        );

  void clearStreams() {
    debouncedMovies.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        debouncedMovies.add([]);
        return;
      }

      final movies = await searchMovies(name: query);
      initialMovies = movies;
      debouncedMovies.add(movies);
      isLoadingStream.add(false);
    });
  }

  @override
  void showResults(BuildContext context) async {
    await searchMovies(name: query).then((movies) {
      initialMovies = movies;
      close(context, SearchResult(products: initialMovies, query: query));
    });
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final products = snapshot.data ?? [];

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) => _MovieItem(
            product: products[index],
            onMovieSelected: (context, product) {
              clearStreams();
              close(
                  context, SearchResult(product: product, products: products));
            },
          ),
        );
      },
    );
  }

  // @override
  // String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                  onPressed: () => query = '',
                  icon: const Icon(Icons.refresh_rounded)),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
                onPressed: () => query = '', icon: const Icon(Icons.clear)),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, SearchResult(products: initialMovies));
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  final Product product;
  final Function onMovieSelected;

  const _MovieItem({required this.product, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, product);
      },
      child: FadeIn(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(product.name, style: textStyles.titleMedium),
        ),
      ),
    );
  }
}

class SearchResult {
  final Product? product;
  final List<Product> products;
  final String query;

  SearchResult({this.product, required this.products, this.query = ''});
}
