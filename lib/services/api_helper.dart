import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/constant/api.dart';
import 'package:ecommerce/model/product.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ApiHelper {
  static Future<List<ProductResModel>> getProduct(BuildContext context) async {
    final dio = Dio();
    try {
      final response = await dio.get("$base_api/products");
      log("All Products: ${response.data.toString()}");
      return List.from(response.data)
          .map<ProductResModel>((e) => ProductResModel.fromjson(e))
          .toList();
    } catch (e) {
      log("Error in getProduct: $e");
      _showError(context, e.toString());
      rethrow;
    }
  }

  static Future<List<String>> getAllCategories(BuildContext context) async {
    final dio = Dio();
    try {
      final response = await dio.get("$base_api/products/categories");
      log("Categories: ${response.data.toString()}");
      return List<String>.from(response.data);
    } catch (e) {
      log("Error in getAllCategories: $e");
      _showError(context, e.toString());
      rethrow;
    }
  }

  static Future<List<ProductResModel>> getProductsByCategory(
      BuildContext context, String categoryName) async {
    final dio = Dio();
    try {
      final response =
          await dio.get("$base_api/products/category/$categoryName");
      log("Products in $categoryName: ${response.data.toString()}");
      return List.from(response.data)
          .map<ProductResModel>((e) => ProductResModel.fromjson(e))
          .toList();
    } catch (e) {
      log("Error in getProductsByCategory: $e");
      _showError(context, e.toString());
      rethrow;
    }
  }

  static void _showError(BuildContext context, String message) {
    if (context.mounted) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Sorry, something went wrong.\n$message',
      );
    }
  }
}
