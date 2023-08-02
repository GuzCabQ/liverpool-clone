import 'package:flutter/material.dart';
import 'package:liverpool/config/config.dart';
import 'package:liverpool/domain/entities/entities.dart';
import 'package:liverpool/presentation/screens/screens.dart';
import 'package:liverpool/presentation/widgets/widgets.dart';

class ProductsList extends StatelessWidget {
  final List<Product> products;
  final bool isLoading;
  final ScrollController? controller;

  const ProductsList({
    super.key,
    required this.products,
    required this.isLoading,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: products.isNotEmpty,
            child: Expanded(
              child: ListView.separated(
                controller: controller,
                itemCount: products.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _ItemProduct(
                    product: product,
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: isLoading,
            child: const Center(
              child: SizedBox(
                child: CircularProgressIndicator(color: ColorsApp.primaryColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ItemProduct extends StatelessWidget {
  const _ItemProduct({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductScreen(product: product),
            ));
      },
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.5,
            height: 250,
            child: Image(
              image: NetworkImage(product.imageUrl!),
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Text('Error al cargar la imagen'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(product.name), ProductData(product: product)],
              ),
            ),
          )
        ],
      ),
    );
  }
}
