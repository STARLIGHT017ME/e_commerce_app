import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wishlist_model.freezed.dart';

@freezed
class WishlistModel with _$WishlistModel {
  const factory WishlistModel({
    required String id,
    required String name,
    required double price,
    required String imageUrl,
  }) = _WishlistModel;
}
