import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomSlider {
  CustomSlider._();

  static show({
    required BuildContext context,
    required String url,
    BoxFit? fit,
    double? radius,
  }) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit ?? BoxFit.fill,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 8),
          color: const Color.fromRGBO(233, 233, 233, 3),
          image: DecorationImage(image: imageProvider, fit: fit ?? BoxFit.fill),
        ),
      ),
      placeholder: (context, url) => Container(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
