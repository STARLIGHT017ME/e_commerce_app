import 'package:e_commerce_app/constraint/app_constraint.dart';
import 'package:e_commerce_app/data/model.dart';
import 'package:e_commerce_app/data/respository/respository.dart';
import 'package:e_commerce_app/data/service/api/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// create an instance of the respository so it can be used across different models
//also integrated flutter provider with it so it can be watche
final respositoryProvider = Provider<Respository>((Ref ref) {
  return Respository(
    ApiService(
      appConstraint: AppConstraint(),
    ),
  );
});
final productProvider = FutureProvider<List<ECommerceModel>>(
  (ref) async {
    final respository = ref.watch(respositoryProvider);
    return respository.getProducts();
  },
);
