import 'package:equatable/equatable.dart';

class Product extends Equatable {
  static const defaultProductImage =
      'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg';
  final String name;
  final double listPrice;
  final double? promoPrice;
  final String? imageUrl;
  final List<String>? colors;

  const Product({
    required this.name,
    required this.listPrice,
    this.promoPrice,
    this.imageUrl = defaultProductImage,
    this.colors,
  });

  @override
  List<Object?> get props => [];
}
