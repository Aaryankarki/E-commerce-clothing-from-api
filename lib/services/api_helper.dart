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
      log(response.data.toString());
      // if (response.statusCode != null) {
      //   setState(() {
      //     products = response.data;
      //   });
      // }
      return List.from(
        response.data,
      ).map<ProductResModel>((e) => ProductResModel.fromjson(e)).toList();
    } catch (e) {
      log("message$e");
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Sorry, something went wrong as$e',
      );
      rethrow;
    }
  }
}