import 'package:ecommerce/model/product.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});
  final ProductResModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.shopping_bag_outlined),
                ),
              ],
            ),
            Expanded(child: Image.network("${product.image}")),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.red,
                ),

                child: Card(
                  child: Column(
                    children: [
                      Text(
                        "${product.title}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "\$ ${product.price}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${product.description}"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
