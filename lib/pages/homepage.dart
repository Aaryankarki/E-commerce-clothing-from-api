import 'package:dio/dio.dart';
import 'package:ecommerce/constant/api.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> products = [];

  void onProduct() async {
    final dio = Dio();
    try {
      final response = await dio.get("$base_api/products");

      if (response.statusCode == 200 && response.data is List) {
        setState(() {
          products = List<Map<String, dynamic>>.from(response.data);
        });
      }

      log(response.data.toString());
    } catch (e) {
      log("Unsuccessful ${e.toString()}");
    }
  }

  @override
  void initState() {
    super.initState();
    onProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body:
          products.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: Image.network(
                        product["image"],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),

                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product["title"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(product["description"]),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
