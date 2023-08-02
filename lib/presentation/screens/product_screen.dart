import 'package:flutter/material.dart';
import 'package:liverpool/config/theme/colors_app.dart';
import 'package:liverpool/domain/entities/product.dart';
import 'package:liverpool/presentation/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width,
              child: Image(
                image: NetworkImage(product.imageUrl!),
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text('Error al cargar la imagen'),
                ),
                fit: BoxFit.cover,
              ),
            ),
            ProductData(product: product),
            Center(
              child: FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: ColorsApp.primaryColor),
                  onPressed: () {},
                  child: const Text('Comprar')),
            )
          ],
        ),
      ),
    );
  }
}
