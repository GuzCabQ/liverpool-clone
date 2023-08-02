import 'package:flutter/material.dart';
import 'package:liverpool/domain/entities/entities.dart';

class Filter<T> extends StatelessWidget {
  final List<Product> products;
  final List<T> items;
  final T? value;
  final Function(T?)? onChanged;
  const Filter(
      {super.key,
      required this.products,
      required this.items,
      required this.value,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return products.isNotEmpty
        ? SizedBox(
            child: DropdownButton<T>(
            value: value,
            hint: const Text('Ordenar'),
            items: items
                .map((e) =>
                    DropdownMenuItem(value: e, child: Text(e.toString())))
                .toList(),
            onChanged: (v) {
              if (onChanged != null) {
                onChanged!(v);
              }
            },
          ))
        : const SizedBox();
  }
}
