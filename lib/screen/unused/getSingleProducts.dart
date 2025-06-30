import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/constant/api.dart';
import 'package:flutter/material.dart';

class GetSingleProducts extends StatefulWidget {
  const GetSingleProducts({super.key});

  @override
  State<GetSingleProducts> createState() => _GetSingleProductsState();
}

class _GetSingleProductsState extends State<GetSingleProducts> {
  List<dynamic> singleProduct = [];
  Future<void> getSingleProducts() async {
    final dio = Dio();
    try {
      final response = await dio.get("$base_api/products");
      if (response.statusCode == 200 && response.data != null) {
        setState(() {
          singleProduct = response.data;
        });
      }
    } catch (e) {
      log("unsuccess to the getSingleProducts");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSingleProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Text("hi"));
  }
}
