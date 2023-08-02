import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String value;
  final String name;

  const Order({required this.value, required this.name});

  @override
  String toString() {
    return name;
  }

  @override
  List<Object?> get props => [name, value];
}
