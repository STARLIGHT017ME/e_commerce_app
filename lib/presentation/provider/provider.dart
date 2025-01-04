import 'package:e_commerce_app/constraint/app_constraint.dart';
import 'package:e_commerce_app/data/respository/respository.dart';
import 'package:e_commerce_app/data/service/api/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final repositoryProvider = Provider<Respository>((ref) {
  return Respository(ApiService(appConstraint: AppConstraint()));
});
