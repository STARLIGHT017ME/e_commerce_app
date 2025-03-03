import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_model.freezed.dart';

@freezed
class CartModel with _$CartModel {
  const factory CartModel(
      {required String id,
      required String name,
      required String price,
      required String imageUrl,
      required int quantity}) = _CartModel;
}
