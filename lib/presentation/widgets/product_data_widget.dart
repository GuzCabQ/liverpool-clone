import 'package:flutter/material.dart';
import 'package:liverpool/config/config.dart';
import 'package:liverpool/domain/entities/entities.dart';

class ProductData extends StatelessWidget {
  final Product product;
  const ProductData({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Formatters().cifraConComas(product.listPrice),
          textScaleFactor: 1,
          style: product.promoPrice != null
              ? const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  decoration: TextDecoration.lineThrough)
              : null,
        ),
        if (product.promoPrice != null)
          Text(Formatters().cifraConComas(product.promoPrice!),
              textScaleFactor: 1,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              )),
        if (product.colors != null)
          Wrap(
            children: product.colors!
                .map(
                  (e) => CircleAvatar(
                      radius: 8, backgroundColor: Formatters().hexToColor(e)),
                )
                .toList(),
          )
      ],
    );
  }
}
